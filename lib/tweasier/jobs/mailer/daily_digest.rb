module Tweasier
  module Jobs
    module Mailer
      class DailyDigest
        @queue = :mailer

        class << self
          def perform(id)
            account = App::Account.find(id)

            return unless account.present? and account.email_notifications == App::Account::EMAIL_NOTIFICATIONS_DAILY

            App::AccountMailer.deliver_daily_digest(account)
          end
        end
      end
    end
  end
end
