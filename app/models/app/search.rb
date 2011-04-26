module App
  class Search < ActiveRecord::Base
    belongs_to :account,  :class_name => "App::Account",         :foreign_key => :account_id
    has_many :conditions, :class_name => "App::SearchCondition", :foreign_key => :search_id, :dependent => :destroy
    has_many :followed_people,   :class_name => "App::Follower::FollowedPerson",   :foreign_key => :search_id, :dependent => :nullify
    has_many :unfollowed_people, :class_name => "App::Follower::UnfollowedPerson", :foreign_key => :search_id, :dependent => :nullify
    has_many :suspended_people,  :class_name => "App::Follower::SuspendedPerson",  :foreign_key => :search_id, :dependent => :nullify
    
    validates_presence_of :account, :title
    validates_uniqueness_of :title, :scope => :account_id
    
    # This method turns the conditions into a tasty search string
    def parameterize
      terms = []
      
      self.conditions.each do |condition|
        terms << condition.parameterize
      end
      
      terms.empty? ? "" : terms.join(" ")
    end
    
  end
end
