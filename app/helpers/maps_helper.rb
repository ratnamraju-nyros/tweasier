module MapsHelper
  
  def render_map lat, long
    render :partial => "app/maps/map", :locals => { :lat => lat, :long => long }
  end
  
end
