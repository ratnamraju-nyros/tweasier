require "tweasier/jobs/auto_follow" # Load background jobs in

module App
  class Account < ActiveRecord::Base

    belongs_to :user
    has_many :searches, :class_name => "App::Search", :foreign_key => :account_id
    has_many :links,    :class_name => "App::Link",   :foreign_key => :account_id
    has_many :followed_people, :class_name => "App::Follower::FollowedPerson",     :foreign_key => :account_id
    has_many :unfollowed_people, :class_name => "App::Follower::UnfollowedPerson", :foreign_key => :account_id
    has_many :suspended_people, :class_name => "App::Follower::SuspendedPerson",   :foreign_key => :account_id
    has_many :ignored_people, :class_name => "App::Follower::IgnoredPerson",       :foreign_key => :account_id
    
    attr_accessible :atoken, :asecret, :user, :auto_follow, :auto_unfollow, :email_notifications, :bitly_token, :bitly_secret, :location
    
    delegate :request_token,
             :access_token,
             :authorize_from_request, :to => :oauth
    
    serialize :location
    
    def screen_name; self.username; end # TODO: remove this username from everywhere and use screen_name
    
    # We know Twitter usernames are already sanitised and don't want friendly_id
    # to alter the format, therefore we preserve the formatting (mainly case) to
    # ensure the account handle remains the same.
    has_friendly_id :username, :use_slug => true do |username|
      username
    end
    
    EMAIL_NOTIFICATIONS_DAILY  = "daily".freeze
    EMAIL_NOTIFICATIONS_WEEKLY = "weekly".freeze
    EMAIL_NOTIFICATIONS_OFF    = "none".freeze
    
    named_scope :auto_followable,   :conditions => { :auto_follow => true }
    named_scope :auto_unfollowable, :conditions => { :auto_unfollow => true }
    named_scope :daily_digest,      :conditions => { :email_notifications => EMAIL_NOTIFICATIONS_DAILY }
    named_scope :weekly_digest,     :conditions => { :email_notifications => EMAIL_NOTIFICATIONS_WEEKLY }
    
    # -------------------------------------
    # Other helpers
    # -------------------------------------
    def is_same_as(person)
      return false unless !person.screen_name.nil?
      self.username == person.screen_name
    end
    alias_method :is_same_as?, :is_same_as
    
    # -------------------------------------
    # Geotagging helpers
    # -------------------------------------
    def geotagging_available?
      self.location and self.location.is_a?(Hash) and self.location[:lat] and self.location[:long]
    end
    
    # -------------------------------------
    # Bitly helpers
    # -------------------------------------
    def link_shortening_available?
      self.bitly_token.present? and self.bitly_secret.present?
    end
    
    def reset_bitly_credentials!
      self.bitly_token  = nil
      self.bitly_secret = nil
      self.save
    end
    
    # -------------------------------------
    # Twitter gem helpers
    # -------------------------------------
    def timeline(query=nil)
      self.client.user_timeline(query)
    end
    
    def limit_information
      @limit_information ||= self.client.rate_limit_status
    end
    
    def authorized?
      self.atoken.present? and self.asecret.present?
    end
    
    def client
      @client ||= begin
        Tweasier::Client::Base.new(self, Configuration.twitter.auth_token, Configuration.twitter.auth_secret)
      end
    end
    
    def follow(user, opts={})
      friend = self.client.friendship_create(user)
      
      if friend
        follow = self.followed_people.build(:user => friend)
        follow.search_id = opts[:search_id] if opts[:search_id]
        follow.save!
      end
      
      friend
    end
    
    # -------------------------------------
    # Resque helpers
    # -------------------------------------
    # Misc Jobs
    def queue_auto_follow!
      # TODO: Here is where we will pass the generate followers task
      # onto Resque to process it in the background. Ensure we only
      # pass JSON encodable values here.
      # TODO: integrate plan limits in here (or just limit how many
      # searches a single account can make?).
      
      Resque.enqueue(Tweasier::Jobs::AutoFollow, self.id)
    end
    
    def queue_auto_unfollow!
      Resque.enqueue(Tweasier::Jobs::AutoUnfollow, self.id)
    end
    
    # Mailers
    def queue_daily_digest_mail!
      Resque.enqueue(Tweasier::Jobs::Mailer::DailyDigest, self.id)
    end
    
    def queue_weekly_digest_mail!
      Resque.enqueue(Tweasier::Jobs::Mailer::WeeklyDigest, self.id)
    end
    
    def queue_follow_limit_exceeded_mail!
      Resque.enqueue(Tweasier::Jobs::Mailer::FollowLimitExceeded, self.id)
    end
    
  end
end
