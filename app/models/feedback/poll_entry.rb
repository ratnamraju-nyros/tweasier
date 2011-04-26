module Feedback
  class PollEntry < ActiveRecord::Base
    belongs_to :answer, :class_name => "Feedback::PollAnswer", :foreign_key => :poll_answer_id
    belongs_to :user
    
    validates_presence_of :answer, :user
    
  end
end
