module NavHelper
  
  def selected_if? id=nil, controller=nil, action=nil
    case
    when (id.present? and action.nil? and controller.nil?)
      "selected" if params[:id] == id.to_s
    when (id.nil? and action.nil?)
      "selected" if @controller.controller_name == controller.to_s
    when (id.nil? and controller.nil?)
      "selected" if @controller.action_name == action.to_s
    when (controller.present? and action.present?)
      "selected" if (@controller.controller_name == controller.to_s) and (@controller.action_name == action.to_s)
    end
  end
  
end
