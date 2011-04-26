module Tweasier
  module Jobs
    module Mailer
      class FollowLimitExceeded
        @queue = :mailer

        class << self
          def perform(id)
            account = App::Account.find(id)

            return unless account.present?

            App::AccountMailer.deliver_follow_limit_exceeded(account)
          end
        end
      end
    end
  end
end
