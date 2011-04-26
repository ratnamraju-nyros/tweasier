module Tweasier
  module Client
    class Base
      attr_accessor :account, :twitter_auth_token, :twitter_auth_secret
      
      def initialize(account, twitter_auth_token, twitter_auth_secret)
        self.account             = account
        self.twitter_auth_token  = twitter_auth_token
        self.twitter_auth_secret = twitter_auth_secret
      end
      
      def method_missing(method_name, *args)
        if local_client.respond_to?(method_name)
          local_client.send(method_name, args)
        else
          remote_client.send(method_name, args)
        end
      end
      
      def local_client
        @local_client ||= begin
          Local.new(self, self.account)
        end
      end
      
      def remote_client
        @remote_client ||= begin
          Remote.new(self.account, self.twitter_auth_token, self.twitter_auth_secret)
        end
      end
      
    end
  end
end
