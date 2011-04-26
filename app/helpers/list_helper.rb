module ListHelper
  
  def render_list(object, collection, context="app")
    render :partial => "#{context}/#{object}/list", :locals => { object.to_sym => collection }
  end
  
end
