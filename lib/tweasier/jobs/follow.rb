module Tweasier
  module Jobs
    class Follow
      @queue = :follower
      
      class << self
        def perform(account_id, screen_name, related_search=nil)
          account = App::Account.find account_id
          
          return unless account and account.auto_follow
          
          # Do a check to see whether the person should be ignored by the follower tool
          if account.ignored_people.collect { |p| p.screen_name }.include?(screen_name)
            Tweasier.logger "#{screen_name} is in the safe list, skipping..."
            return
          end
          
          Tweasier.logger "Sleeping for #{Tweasier::Follower::Base::SLEEP_INTERVAL} seconds."
          sleep(Tweasier::Follower::Base::SLEEP_INTERVAL)
          
          begin
            opts = {}
            opts.merge!(:search_id => related_search) if related_search
            
            Tweasier.logger "- Attempting to follow #{screen_name}..."
            user = account.follow(screen_name, opts)
            Tweasier.logger "+ Now following #{screen_name} (#{user.id})"
            
          rescue Twitter::General => error
            case error.data["error"]
            when /suspended/
              user = account.client.user(screen_name)
              
              if user
                opts = {:user => user}
                opts.merge!(:search_id => related_search) if related_search
                account.suspended_people.build(opts).save!
                Tweasier.logger "! [Error] Could not befriend #{screen_name} as their account has been suspended by Twitter. Added them to the suspended list."
              else
                Tweasier.logger "! [Error] Could not befriend #{screen_name} as their account has been suspended by Twitter. Failed to add them to the suspended list."
              end
            when /already on your list/
              user = account.client.user(screen_name)
              
              if user
                account.ignored_people.build(:user => user).save!
                Tweasier.logger "! [Error] Could not befriend #{screen_name} as they were already #{account.username}'s friend. Added #{screen_name} to ignored list."
              else
                Tweasier.logger "! [Error] Could not befriend #{screen_name} as they were already #{account.username}'s friend. Failed to add them to the ignored list."
                HoptoadNotifier.notify(error) # notify hoptoad
              end
            when /You have been blocked from following this account/
              user = account.client.user(screen_name)
              
              if user
                account.ignored_people.build(:user => user).save!
                Tweasier.logger "! [Error] Could not befriend #{screen_name} as they requested not to be followed by #{account.username}. Added #{screen_name} to ignored list."
              end
              
              HoptoadNotifier.notify(error) # notify hoptoad
            when /You are unable to follow more people at this time/
              # disable auto follow
              account.auto_follow = false
              account.save!
              
              # send notification to account owner
              account.queue_follow_limit_exceeded_mail!
              
              Tweasier.logger "! [Error] RATE LIMIT REACHED FOR #{account.screen_name}. Sent warning mail and turned follower off until further instruction."
              HoptoadNotifier.notify(error) # notify hoptoad
            else
              HoptoadNotifier.notify(error) # notify hoptoad
              Tweasier.logger "! [Error] Could not befriend #{screen_name} => #{error.data["error"]}"
              # TODO: assuming hoptoad is notifying us we can remove this raise...
              raise "Could not rescue Twitter error => #{error.inspect}"
            end
          rescue Twitter::NotFound => error
            Tweasier.logger "! [Error] Could not befriend #{screen_name} => 404 not found (aka gone walkies)"
          # Don't rescue anything else at the moment, we need to recognise errors in Resque.
          #rescue Twitter::RateLimitExceeded => error
          #  Tweasier.logger "! [Error] Could not befriend #{screen_name} => Rate limit has been exceeded"
          #  exit
          #rescue Twitter::Unauthorized => error
          #  Tweasier.logger "! [Error] Could not befriend #{screen_name} => Account is unauthorised"
          #  exit
          #rescue Twitter::InformTwitter => error
          #  Tweasier.logger "! [Error] Could not befriend #{screen_name} => An error occured with Twitters codes"
          #rescue Twitter::Unavailable => error
          #  Tweasier.logger "! [Error] Could not befriend #{screen_name} => Failed to contact Twitter"
          end
        end
      end
    end
  end
end
