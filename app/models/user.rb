class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :accounts,     :class_name => "App::Account", :foreign_key => :user_id, :dependent => :destroy
  has_many :poll_entries, :class_name => "Feedback::PollEntry", :foreign_key => :user_id, :dependent => :nullify
  has_many :feedback_entries, :class_name => "Feedback::FeedbackEntry", :foreign_key => :user_id, :dependent => :nullify
  
  validates_length_of :password, :in => 6..30
  
  after_save :debug
  
  def debug
    logger.info "PASSWORD: #{password.inspect}"
    logger.info "PASSWORD CONF: #{password_confirmation.inspect}"
  end
  
  def handle
    self.email.split("@").first rescue self.email
  end
  
  def answered_poll_ids
    self.poll_entries.collect { |e| e.answer.poll_id }.uniq
  end
  
end
