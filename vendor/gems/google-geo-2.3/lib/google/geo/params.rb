module Google
class  Geo
class  Params < Hash
  def initialize(geo, *args)
    @geo = geo
    
    params = { :key => @geo.key, :output => "xml", :hl => @geo.language, :oe => "utf-8" }
    
    query = case args.size
    when 1
      case args
      when String then args
      when Array  then args.join(",")
      end
    when 2
      args.join(",")
    else
      raise ArgumentError, "dunno what to do with #{args.inspect}"
    end
    
    params[:q] = query
    
    replace params
  end
  
  def to_uri
    uri = "http://maps.google.com/maps/geo?" <<
      map { |k,v| "#{k}=#{URI.escape v.to_s}" }.join("&")
    # puts uri
    uri
  end
  
  def extract_dimensions!
    if size = delete(:size)
      size.split("x")
    elsif self[:width] and self[:height]
      [delete(:width), delete(:height)]
    else
      [500, 300]
    end
  end
end
end
end
