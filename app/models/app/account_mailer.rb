module App
  class AccountMailer < BaseMailer
    
    def daily_digest(account)
      setup_mail(account.user.email)
      @subject        += "Daily Digest"
      @body            = { :local_account => account }.merge!(get_digest_data(account))
    end
    
    def weekly_digest(account)
      setup_mail(account.user.email)
      @subject        += "Weekly Digest"
      @body            = { :local_account => account }.merge!(get_digest_data(account, 4000))
    end
    
    def follow_limit_exceeded(account)
      setup_mail(account.user.email)
      @subject        += "Follow Limit Exceeded!"
      @body            = { :account => account, :twitter_account => account.client.user(account.username) }
    end
    
    private
    def get_digest_data(account, followed_limit=2000, unfollowed_limit=1000)
      twitter_account  = account.client.user(account.username)
      
      followed_people           = account.followed_people.all :limit => followed_limit
      unfollowed_people         = account.unfollowed_people.all :limit => unfollowed_limit
      searches                  = account.searches.all
      
      grouped_followed_people   = followed_people.group_by { |p| p.created_at.beginning_of_day }
      grouped_unfollowed_people = unfollowed_people.group_by { |p| p.created_at.beginning_of_day }
      
      { :grouped_followed_people   => grouped_followed_people,
        :searches                  => searches,
        :grouped_unfollowed_people => grouped_unfollowed_people,
        :twitter_account           => twitter_account }
    end
    
  end
end
