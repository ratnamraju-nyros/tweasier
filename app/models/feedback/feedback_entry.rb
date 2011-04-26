module Feedback
  class FeedbackEntry < ActiveRecord::Base
    
    belongs_to :user
    
    validates_presence_of :user, :content
    
  end
end
