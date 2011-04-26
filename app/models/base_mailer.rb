class BaseMailer < ActionMailer::Base
  layout "mailer"
  default_url_options[:host] = HOST
  
  protected
  def setup_mail(email)
    from          DO_NOT_REPLY
    recipients    email
    subject      "[Tweasier] "
    sent_on       Time.now
  end
  
end
