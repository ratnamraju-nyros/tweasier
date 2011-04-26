module Feedback
  class Poll < ActiveRecord::Base
    has_many :answers, :class_name => "Feedback::PollAnswer", :foreign_key => :poll_id, :dependent => :destroy
    
    validates_uniqueness_of :title
    
    def entries
      self.answers.collect { |a| a.entries }.flatten
    end
    
    def self.random(scoped_user=nil)
      conditions = { :active => true }
      
      if scoped_user
        ignore_ids = scoped_user.answered_poll_ids
        conditions = ['active = ? AND id NOT IN (?)', true, ignore_ids] if ignore_ids.present?
      end
      
      ids = self.find(:all, :select => "id, active", :conditions => conditions).collect { |p| p.id }
      self.find(ids[rand(ids.length)]) unless ids.blank?
    end
    
  end
end
