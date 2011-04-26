module Feedback
  class PollAnswer < ActiveRecord::Base
    belongs_to :poll, :class_name => "Feedback::Poll", :foreign_key => :poll_id
    has_many :entries, :class_name => "Feedback::PollEntry",  :foreign_key => :poll_answer_id, :dependent => :destroy
    
    validates_presence_of :poll

  end
end
