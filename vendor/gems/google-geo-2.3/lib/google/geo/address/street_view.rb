require "google/geo"

module Google
class  Geo
class  Address
  # This is a shady method which relies on an unofficial Google API.
  # Use at your own risk!
  def street_view_html(options = {})
%{<embed id="#{options[:id] or 'google-geo-streetview'}"
  style="#{options[:style]}"
  src="http://maps.google.com/mapfiles/cb/googlepano.066.swf"
  quality="high" wmode="opaque" swliveconnect="false"
  allowscriptaccess="always" type="application/x-shockwave-flash"
  pluginspage="http://www.macromedia.com/go/getflashplayer" 
  scale="noscale" salign="lt"
  flashvars="panoId=#{street_view_pano_id}&amp;directionMap=N:N,W:W,S:S,E:E,NW:NW,NE:NE,SW:SW,SE:SE&amp;yaw=0&amp;zoom=0&amp;browser=3&amp;pitch=5&amp;viewerId=1&amp;context=api&amp;animateOnLoad=false&amp;useSsl=false"
></embed>}.gsub("\n", "").squeeze(" ")
  end
  
private
  def street_view_pano_id
    url = "http://maps.google.com/cbk?output=xml&oe=utf-8&cb_client=api&ll=#{lat},#{lng}"
    # "&callback=_xdc_._0fqdyf9p2"
    open(url).read.slice(/pano_id="([^"]+)"/, 1)
  end
end
end
end
