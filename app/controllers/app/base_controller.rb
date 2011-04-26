module App
  class BaseController < ApplicationController
    include Utils
    include Charts
    
    before_filter :get_current_user,
                  :get_account,
                  :set_application_context
    
    before_filter :authenticate,
                  :assign_default_page
                  
    before_filter :get_poll,
                  :get_feedback_entry
    
    # If for some reason the oatuh fails, the credentials supplied are no longer any use.
    # We need to get them to re-authenticate the twitter account with the app.
    rescue_from(Twitter::Unauthorized) do |exception|
      reset_session
      flash[:error] = 'Sorry, there was a problem authenticating your account. Please add your account again.'
      redirect_to new_app_user_account_path
    end
    
    # When twitter times out
    rescue_from(Errno::ECONNRESET) do |exception|
      render_error 500
    end
    rescue_from(Twitter::Unavailable) do |exception|
      render_error 500
    end
    
    protected
    def get_current_user
      @user ||= current_user
    end
    
    def get_account
      return unless @user and params[:account_id]
      @account ||= @user.accounts.find params[:account_id]
    end
    
    def get_poll
      @poll ||= Feedback::Poll.random(@user)
    end
    
    def get_feedback_entry
      @feedback_entry ||= Feedback::FeedbackEntry.new
    end
    
    def assign_default_page
      params[:page] ||= 1
    end
    
    def set_application_context
      @within_application = true
    end
  end
end
