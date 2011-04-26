require "test_helper"

class GeoTest < Test::Unit::TestCase  
  def setup    
    @geo = Google::Geo.new 'API_KEY'
  end

  def test_success
    stub_response! :success
         # show that query is escaped
         # with("http://maps.google.com/maps/geo?q=1600%20Amphitheatre%20Parkway,%20Mountain%20View,%20CA&key=API_KEY&output=xml&hl=en&oe=utf-8").
    
    query = '1600 Amphitheatre Parkway, Mountain View, CA'
    
    address = @geo.locate(query).first
    
    assert_equal '1600 Amphitheatre Pkwy', address.street
    assert_equal address.street, address.thoroughfare
    
    assert_equal 'Mountain View', address.city
    assert_equal address.city, address.locality
    
    assert_equal '94043', address.zip
    assert_equal address.zip, address.postal_code
    
    assert_equal 'Santa Clara', address.county
    assert_equal address.county, address.subadministrative_area
    
    assert_equal 'CA', address.state
    assert_equal address.state, address.administrative_area
    
    assert_equal 'US', address.country
    assert_equal address.country, address.country_code
    
    assert_equal -122.083739, address.longitude
    assert_equal address.longitude, address.lng
    
    assert_equal 37.423021, address.latitude
    assert_equal address.latitude, address.lat
    
    assert_equal 0, address.elevation
    
    assert_equal [address.longitude, address.latitude, address.elevation], address.coordinates
    
    assert_equal 8, address.accuracy
    
    assert_equal '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA', address.full_address
    assert_equal query, address.query
  end
  
  def test_success_with_multiple_addresses
    stub_response! :success_with_multiple_addresses
    
    heavens = @geo.locate('heaven')
    
    assert_equal 2, heavens.size
    
    assert_equal 'Heaven, Pottsville, PA 17901, USA', heavens[0].full_address
    assert_equal 'Heaven, Oakboro, NC 28129, USA', heavens[1].full_address
    
    heavens.each { |h| assert_kind_of Google::Geo::Address, h }
  end
  
  def test_has_an_accessible_language_attribute_defaulting_to_english
    assert_equal 'en', @geo.language
    @geo.language = 'de'
    assert_equal 'de', @geo.language
  end
  
  def test_can_get_results_in_german
    stub_response! :success_german
         # with("http://maps.google.com/maps/geo?q=Z%C3%BCrich,%20Schweiz&key=API_KEY&output=xml&hl=de&oe=utf-8").
    @geo.language = 'de'
    address = @geo.locate('Zürich, Schweiz').first
    assert_equal 'Zürich, Schweiz', address.full_address
  end
  
  def test_gets_english_results_by_default
    stub_response! :success_english
         # with("http://maps.google.com/maps/geo?q=Z%C3%BCrich,%20Schweiz&key=API_KEY&output=xml&hl=en&oe=utf-8").
    address = @geo.locate('Zürich, Schweiz').first
    assert_equal 'Zürich, Switzerland', address.full_address
  end
  
  def test_invalid_map_key
    stub_response! :invalid_map_key
    assert_raises(Google::Geo::InvalidMapKeyError) { @geo.locate 'foo' }
  end

  def test_missing_address
    stub_response! :missing_address
    assert_raises(Google::Geo::MissingAddressError) { @geo.locate 'foo' }
  end

  def test_server_error
    stub_response! :server_error
    assert_raises(Google::Geo::ServerError) { @geo.locate 'foo' }
  end

  def test_too_many_queries
    stub_response! :too_many_queries    
    assert_raises(Google::Geo::TooManyQueriesError) { @geo.locate 'foo' }
  end

  def test_unavailable_address
    stub_response! :unavailable_address
    assert_raises(Google::Geo::UnavailableAddressError) { @geo.locate 'foo' }
  end

  def test_unknown_address
    stub_response! :unknown_address
    assert_raises(Google::Geo::UnknownAddressError) { @geo.locate 'foo' }
  end
end