module Tweasier
  module Follower
    class Filter
      attr_accessor :account, :results, :existing_follower_screen_names, :new_follower_screen_names
      # This class filters out all existing and new follower screen_names into 
      # a new array of unique screen_names.
            
      def initialize(account, results)
        self.account = account
        self.results = results || []
      end
      
      def run!
        self.existing_follower_screen_names = get_existing_follower_ids!
        self.new_follower_screen_names      = get_new_follower_screen_names!
        
        filter_unique_screen_names_from_batch!
        filter_screen_names_according_to_plan!
        
        self.new_follower_screen_names
      end
      
      private
      def get_existing_follower_ids!
        # Get known follower screen names from twitter
        # TODO: need to get usernames instead of IDs
        known_twitter_follower_screen_names = []
        # known_twitter_follower_ids = self.account.client.follower_ids
        
        # The get known followed//unfollowed/ignored/suspended users from local (and add yourself just in case you pop up in the search results).
        known_local_follower_screen_names  = self.account.followed_people.collect { |p| p.screen_name }
        known_local_follower_screen_names << self.account.unfollowed_people.collect { |p| p.screen_name }
        known_local_follower_screen_names << self.account.ignored_people.collect { |p| p.screen_name }
        known_local_follower_screen_names << self.account.suspended_people.collect { |p| p.screen_name }
	
	## Add this array to black list members
        known_local_follower_screen_names << self.account.blacklists.collect { |p| p.screen_name }
	
        known_local_follower_screen_names << self.account.username
        known_local_follower_screen_names << self.account.username.downcase
        
        # Then filter out the duplicates
        (known_twitter_follower_screen_names | known_local_follower_screen_names).uniq
      end
      
      def get_new_follower_screen_names!        
	 self.results.collect { |r| filter_results_followers_greater_than_ten(self.account, r) }.uniq  
     end
     
      def filter_results_followers_greater_than_ten(account, follower, limit=10)
           person   = account.client.user(follower.from_user)
	   if person.followers_count.to_i > limit
            return follower.from_user 
          end    
      end
      
      
      
      def filter_unique_screen_names_from_batch!
        self.new_follower_screen_names.reject! { |name| self.existing_follower_screen_names.include?(name) }
      end
      
      def filter_screen_names_according_to_plan!
        # Filter logic for the current accounts plan could go in here.
        # Its possible to have at least +10 for every set of results so
        # we need to throttle this in order to ensure limits are obeyed.
        
        # For now lets limit this to 10
        self.new_follower_screen_names = self.new_follower_screen_names.slice(0,10) rescue nil
      end
    end
  end
end
