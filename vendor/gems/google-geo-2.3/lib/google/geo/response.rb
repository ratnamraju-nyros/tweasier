require "google/geo/parser"

#:stopdoc:
module Google
class  Geo

class Response #:nodoc:
  include Parser
  
  attr_reader :geo, :params, :xml, :query, :status
  
  def initialize(geo, params) #:nodoc
    @geo = geo
    
    @params = params
    @xml = open(params.to_uri).read
    
    @query  = fetch(:name)
    @status = fetch(:code).to_i
    
    case @status
      when 200 then # Success
      when 500 then raise ServerError, "Unknown error from Google's server"
      when 601 then raise MissingAddressError, "Missing address"
      when 602 then raise UnknownAddressError, "Unknown address: #{@query}"
      when 603 then raise UnavailableAddressError, "Unavailable address: #{@query}"
      when 610 then raise InvalidMapKeyError, "Invalid map key: #{@geo.key}"
      when 620 then raise TooManyQueriesError, "Too many queries for map key: #{@geo.key}"
      when 400 then raise BadRequestError, "Bad request: #{@status}"
      else          raise UnknownError, "Unknown error: #{@status}"
    end
    
    @placemarks = @xml.scan %r{<Placemark(?: id="p\d+")?>.+?</Placemark>}m
  end
  
  def addresses
    @placemarks.map { |p| Address.new p, @query, @geo }
  end
end

end
end
#:startdoc:
