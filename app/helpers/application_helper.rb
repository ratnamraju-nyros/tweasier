# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def shared(item, opts={})
    namespace = opts[:namespace]  ? "#{opts[:namespace].to_s}/" : ""
    render :partial => "#{namespace}shared/#{item}", :locals => opts
  end
  
  def blog_path
    "/blog"
  end
  
  def within_application?
    signed_in? and @within_application
  end
  
  def sidebar(&block)
    content_for :sidebar do
      capture(&block)
    end
  end
  
  def yield_javascript_vars
    return unless current_user
    
    vars =  "window._current_user       = #{current_user.id};\n"
    vars += "window._authenticity_token = '#{create_authenticity_token}';\n"
    
    if @account
      vars += "window.statuses_path           = '#{app_user_account_statuses_path(@account) if @account}';\n"
      vars += "window.direct_messages_path    = '#{app_user_account_direct_messages_path(@account) if @account}';\n"
      vars += "window.new_search_batches_path = '#{new_app_user_account_search_batch_path(@account) if @account}';"
    end
      
    javascript_tag vars
  end
  
  def create_authenticity_token
    (protect_against_forgery?) ? form_authenticity_token : ''
  end
  
  def id_is?(action)
    params[:id] == action.to_s
  end
  
  def action_is?(action)
    @controller.action_name == action.to_s
  end
  
  def controller_is?(controller)
    @controller.controller_name == controller.to_s
  end
  
  def controller_and_action_is?(controller, action)
    @controller.controller_name == controller.to_s and @controller.action_name == action.to_s
  end
  
end
