module Tweasier
  module Jobs
    class AutoUnfollow
      @queue = :auto_unfollower
      
      class << self
        def perform(account_id)
          account = App::Account.find account_id
          
          raise "No account found with the id #{account_id}!" unless account.present?
          raise "This account is not enabled for the bulk unfollow tool!" unless account.auto_unfollow?
          
          # TODO: better way to limit, normal finder limit doesnt seem to work!?
          people = account.followed_people.for_unfollower.slice(0,10)
          
          return unless people.present?
          
          ignored_people    = account.ignored_people.collect { |p| p.screen_name }
          unfollowed_people = account.unfollowed_people.collect { |p| p.screen_name }
          
          people.each do |person|
            # Do a check to see whether the person should be ignored by the unfollower tool
            if ignored_people.include?(person.screen_name) or unfollowed_people.include?(person.screen_name)
              person.destroy
              Tweasier.logger "#{person.screen_name} is in the safe list, skipping and removing from list..."
              next
            end
            
            # First check if they are following
            Tweasier.logger "Checking if #{person.screen_name} is following #{account.screen_name}"
            
            
            begin
              result = account.client.friendship_show(:source_screen_name => account.screen_name,
                                                      :target_screen_name => person.user.screen_name)
            rescue Twitter::NotFound => error
              # HoptoadNotifier.notify(error) # notify hoptoad
              
              # remove that person from the list as they are missing
              ignored = account.ignored_people.build(person.attributes)
              ignored.save!
              ignored.touch
              person.destroy
              Tweasier.logger "Friendship between #{person.screen_name} and #{account.screen_name} was not found, or the user was missing. Added to ignored."
              
              next
            rescue Twitter::Unavailable => error
              HoptoadNotifier.notify(error) # notify hoptoad
              Tweasier.logger "Unable to show friendship as Twitter is unavailable."
              result = nil
            end
            
            if result and result.relationship.source.followed_by
              Tweasier.logger "#{person.screen_name} is following #{account.screen_name}, flagged as OK."
              
              person.mutual_follow = true
              person.save!
            else
              # If they are not following the account we unfollow them and remove the followed person from
              # the list of followed people, placing them in the unfollowed person list.
              
              begin
                account.client.friendship_destroy(person.user.screen_name)
                  
                unfollowed = account.unfollowed_people.build(person.attributes)
                unfollowed.save!
                unfollowed.touch
                person.destroy
                Tweasier.logger "Unfollowed #{person.screen_name} for account #{account.screen_name} and removed from followed list."
              rescue StandardError => error
                if error.respond_to?(:data) and error.data["error"] =~ /You are not friends/
                  # remove that person from the list as they have already been unfollowed/never were followed.
                  ignored = account.ignored_people.build(person.attributes)
                  ignored.save!
                  ignored.touch
                  person.destroy
                  Tweasier.logger "Was not friends with #{person.screen_name} on account #{account.screen_name}. Added to ignored list."
                else
                  Tweasier.logger "Uncapturable error from unfollow tool for #{person.screen_name} on account #{account.screen_name}"
                  if error.respond_to?(:data)
                    raise "Uncapturable error unfollowing #{person.user.screen_name} for account #{account.screen_name} => #{error.data.inspect}"
                  else
                    raise "Uncapturable error unfollowing #{person.user.screen_name} for account #{account.screen_name} => #{error.inspect}"
                  end
                end
              end
            end
          end
        end
      end
      
    end
  end
end
