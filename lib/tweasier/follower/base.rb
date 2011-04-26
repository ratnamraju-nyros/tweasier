module Tweasier
  module Follower
    class Base
      attr_accessor :account
      
      # If we don't sleep Twitter tends to dislike us. We need to experiment
      # with this number or look into a way we can approach following less
      # systematically. For now this is pretty cautious but seems like any less
      # will result in a 404.
      SLEEP_INTERVAL = 45.freeze # 120~ is usually good.
      
      def initialize(account_id, opts={})
        self.account = App::Account.find(account_id)
      end
      
      def run!
        return true unless valid_account?
        Tweasier.logger "MATT - account is #{account.inspect}" 
        self.account.searches.each do |search|
          Tweasier.logger "MATT search is #{search.parameterize.inspect}"
          next if search.parameterize.blank?
          
          results                = perform_search!(search.parameterize)
          Tweasier.logger "MATT reslts count  are #{results.length}"
          screen_names_to_follow = filter_search!(results)
          Tweasier.logger "MATT screen names oto follow are #{screen_names_to_follow.length}"
          auto_follow!(screen_names_to_follow, search)
        end
      end
      
      private
      def valid_account?
        self.account.searches.present?
      end
      
      def perform_search!(term)
        Tweasier::Search::Base.new(term).run!
      end
      
      def filter_search!(results)
        Tweasier::Follower::Filter.new(self.account, results).run!
      end
      
      def auto_follow!(screen_names, search)
        if screen_names.present?
          Tweasier.logger "Auto following these users:"
          screen_names.each { |screen_name| Tweasier.logger "+ #{screen_name}" }
          screen_names.each { |screen_name| Resque.enqueue(Tweasier::Jobs::Follow, self.account.id, screen_name, search.id) }
        else
          Tweasier.logger "No users found to auto follow for #{self.account.username}!"
        end
      end
    end
  end
end
