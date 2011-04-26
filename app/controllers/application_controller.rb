require 'twitter'
class ApplicationController < ActionController::Base
  include Clearance::Authentication
  include Tweasier::Authentication
  
  helper :all
  filter_parameter_logging :password, :password_confirmation
  protect_from_forgery
  
  protected
  def render_error(code)
    redirect_to "/#{code.to_s}.html"
  end
  
end
