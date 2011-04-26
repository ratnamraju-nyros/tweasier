require "open-uri"
require "google/geo/params"
require "google/geo/response"
require "google/geo/address"

module Google
# Please see README for usage examples.
class  Geo
  # API key provided by Google allowing access to the Geocode API
  attr_accessor :key, :language
  
  # The last response received after a :locate call
  attr_reader :last_response

  # Google's XML files state that they are utf-8 encoded which is not true.
  # Because they state this explicitly, I see no need to let users set
  # another charset.
  CHARSET = "utf-8"
  def charset; CHARSET; end
  
  DEFAULT_LANGUAGE = "en"
  
  def initialize(key, language = DEFAULT_LANGUAGE)
    @key      = key
    @language = language
  end
    
  #   >> geo.locate "1600 Pennsylvania Ave"
  # 
  #   # reverse locate
  #   >> geo.locate 33.998671, -118.075926
  # 
  # Returns an array of Address objects, 
  # each with accessors for all the components of a location.
  def locate(*params)
    @last_response = Response.new(self, Params.new(self, *params))
    @last_response.addresses
  end
  
  ###
  
  class Error < Exception; end
    
  class ServerError     < Error; end
  class BadRequestError < Error; end
    
  class AddressError < Error; end
  class MissingAddressError     < AddressError; end
  class UnknownAddressError     < AddressError; end
  class UnavailableAddressError < AddressError; end
    
  class MapKeyError < Error; end
  class InvalidMapKeyError  < MapKeyError; end
  class TooManyQueriesError < MapKeyError; end
  
  class UnknownError < Error; end
end

end