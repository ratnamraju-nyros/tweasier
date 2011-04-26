module Tweasier
  module Client
    class Local
      attr_accessor :account, :fallback_client, :cache_key_prefix
      
      def initialize(base, account)
        self.account          = account
        self.cache_key_prefix = account.screen_name
        self.fallback_client  = base.remote_client
      end
      
      def friends_timeline(*args)
        get_or_set_with(:friends_timeline, :friends_timeline, *args)
      end
      
      def rate_limit_status(*args)
        get_or_set_with(:rate_limit, :rate_limit_status, *args)
      end
      
      def retweeted_by_me(*args)
        get_or_set_with(:retweeted_by_me, :retweeted_by_me, *args)
      end
      
      def retweeted_to_me(*args)
        get_or_set_with(:retweeted_to_me, :retweeted_to_me, *args)
      end
      
      def retweets_of_me(*args)
        get_or_set_with(:retweets_of_me, :retweets_of_me, *args)
      end
      
      def mentions(*args)
        get_or_set_with(:mentions, :mentions, *args)
      end
      
      def direct_messages(*args)
        get_or_set_with(:direct_messages, :direct_messages, *args)
      end
      
      def favorites(*args)
        get_or_set_with(:favorites, :favorites, *args)
      end
      
      def status(*args)
        get_or_set_with(:status, :status, *args)
      end
      
      def user(*args)
        get_or_set_with(:user, :user, *args)
      end
      
      def user_timeline(*args)
        get_or_set_with(:user_timeline, :user_timeline, *args)
      end
      
      protected
      def cache_keys
        {
          :rate_limit       => { :label => "#{self.cache_key_prefix}_rate_limit", :expires => 2.minutes },
          :friends_timeline => { :label => "#{self.cache_key_prefix}_friends_timeline", :expires => 1.minute },
          :retweeted_by_me  => { :label => "#{self.cache_key_prefix}_retweeted_by_me", :expires => 3.minutes },
          :retweeted_to_me  => { :label => "#{self.cache_key_prefix}_retweeted_to_me", :expires => 3.minutes },
          :retweets_of_me  => { :label => "#{self.cache_key_prefix}_retweets_of_me", :expires => 3.minutes },
          :mentions  => { :label => "#{self.cache_key_prefix}_mentions", :expires => 3.minutes },
          :direct_messages  => { :label => "#{self.cache_key_prefix}_direct_messages", :expires => 5.minutes },
          :favorites  => { :label => "#{self.cache_key_prefix}_favorites", :expires => 10.minutes },
          :status  => { :label => "status", :expires => 30.days },
          :user  => { :label => "#{self.cache_key_prefix}_user", :expires => 10.minutes },
          :user_timeline => { :label => "#{self.cache_key_prefix}_user_timeline", :expires => 2.minutes }
          
        }
      end
      
      def get_or_set_with(key, fallback_method, *args)
        type = key
        key  = construct_key(key, *args)
        
        if exists?(key)
          get(key)
        else
          opts = {}
          opts.merge!(:expires_in => cache_keys[type][:expires]) if cache_keys[type][:expires].present?
          
          set(key, self.fallback_client.send(fallback_method, *args), opts)
          get(key)
        end
      end
      
      def construct_key(key, *args)
        # This is a bit of a dirty way to construct a unique cache key for
        # methods containing additional parameters (e.g. page/since_id etc).
        seperator = "_"
        args.flatten!
        
        if !args.empty?
          if args.first.is_a?(Hash) and (page = args.first[:page])
            [cache_keys[key][:label], "page" , page].join(seperator)
          elsif args.first.is_a?(String) and (id = args.first)
            # This concept is heavily based on the fact that the initial arg
            # is a globally used resource, not just per accoiunt (e.g. viewing a
            # status or a user profile).
            [cache_keys[key][:label], id].join(seperator)
          else
            cache_keys[key][:label]
          end
        else
          cache_keys[key][:label]
        end
      end
      
      def get(key)
        Tweasier::Cache::Base.get(key)
      end
      
      def set(key, value, opts={})
        opts.merge!(:expires_in => 2.minutes) unless opts[:expires_in]
        
        Tweasier::Cache::Base.set(key, value, opts)
      end
      
      def destroy(key)
        Tweasier::Cache::Base.destroy(key)
      end
      
      def exists?(key)
        Tweasier::Cache::Base.exists?(key)
      end
    end
  end
end
