module App
  class Link < ActiveRecord::Base
    belongs_to :account, :class_name => "App::Account", :foreign_key => :account_id
    
    delegate :bitly_token, :bitly_secret, :to => :account
    
    validates_presence_of :unique_hash, :user_hash, :long_url, :short_url, :account
    
    serialize :referrers
    
    default_scope :order => "created_at DESC"
    
    def test!
      begin
        result = client.shorten("http://test.com", :history => 0)
        result.hash.present?
      rescue
        false
      end
    end
    
    def shorten!
      result = client.shorten(self.long_url, :history => 1)
      
      self.long_url    = result.long_url
      self.short_url   = result.short_url
      self.unique_hash = result.hash
      self.user_hash   = result.user_hash
      self.save!
      
      self
    end
    
    def refresh_statistics!
      result = client.stats(self.short_url)
      
      self.cached_clickcount      = result.stats["clicks"]
      self.cached_user_clickcount = result.stats["userClicks"] if result.stats["userClicks"].present?
      self.referrers              = result.stats["referrers"]
      
      self.save!
      self
    end
    
    def client
      @client ||= Bitly.new(self.bitly_token, self.bitly_secret)
    end
    
  end
end
