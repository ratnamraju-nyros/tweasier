module Tweasier
  module Jobs
    module Mailer
      class WeeklyDigest
        @queue = :mailer

        class << self
          def perform(id)
            account = App::Account.find(id)

            return unless account.present? and account.email_notifications == App::Account::EMAIL_NOTIFICATIONS_WEEKLY

            App::AccountMailer.deliver_weekly_digest(account)
          end
        end
      end
    end
  end
end
