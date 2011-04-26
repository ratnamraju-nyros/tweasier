require "google/geo/parser"

module Google
class  Geo
# Represents locations returned in response to geocoding queries.
class Address
  include Parser
  
  attr_reader :street
  alias :thoroughfare :street
  
  attr_reader :city
  alias :locality :city
  
  attr_reader :zip
  alias :postal_code :zip
  
  attr_reader :county
  alias :subadministrative_area :county
  
  attr_reader :state
  alias :administrative_area :state
  
  attr_reader :country
  alias :country_code :country
  
  # An array containing the standard three elements of a coordinate triple: latitude, longitude, elevation.
  attr_reader :coordinates
  
  # A float, the standard first element of a coordinate triple.
  attr_reader :longitude
  alias :lng :longitude
  
  # A float, the standard second element of a coordinate triple.
  attr_reader :latitude
  alias :lat :latitude
  
  # A float, the standard third element of a coordinate triple.
  attr_reader :elevation
  
  # An integer, Google's rating of the accuracy of the supplied address.
  attr_reader :accuracy
  
  # All address attributes as one string, formatted by the service.
  attr_reader :full_address
  alias :to_s :full_address
  
  # The address query sent to the service. i.e. The user input.
  attr_reader :query
  
  def initialize(placemark, query, geo) #:nodoc
    @geo   = geo
    @xml   = placemark
    @query = query

    { :@street       => :ThoroughfareName,
      :@city         => :LocalityName,
      :@zip          => :PostalCodeNumber,
      :@county       => :SubAdministrativeAreaName,
      :@state        => :AdministrativeAreaName,
      :@country      => :CountryNameCode,
      
      :@full_address => :address
    }.each do |attribute, element|
      instance_variable_set(attribute, (fetch(element) rescue nil))
    end
    
    @longitude, @latitude, @elevation = 
      @coordinates = fetch(:coordinates).split(",").map { |x| x.to_f }
    
    @accuracy = fetch_accuracy
  end
end
end
end
