module Tweasier
  module Client
    class Remote
      attr_accessor :account, :auth_token, :auth_secret
      
      def initialize(account, auth_token, auth_secret)
        self.account     = account
        self.auth_token  = auth_token
        self.auth_secret = auth_secret
      end
      
      def method_missing(method_name, args)
        # Delegate any method calls to the remote client.
        self.twitter_client.send(method_name, *args)
      end
      
      protected
      def oauth
        @oauth ||= Twitter::OAuth.new(self.auth_token, self.auth_secret)
      end
      
      def twitter_client
        @twitter_client ||= begin
          oauth.authorize_from_access(self.account.atoken, self.account.asecret)
          Twitter::Base.new(oauth)
        end
      end
      
    end
  end
end
