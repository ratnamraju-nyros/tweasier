require "test_helper"

class ReverseLocateTest < Test::Unit::TestCase  
  def setup    
    @geo = Google::Geo.new 'API_KEY'
  end
  
  def test_should_locate_with_latlon
    stub_response! :reverse_locate_success
    # with("http://maps.google.com/maps/geo?ll=33.998671,-118.075926&key=API_KEY&output=xml&hl=en&oe=utf-8").
    
    location = @geo.locate(33.998671, -118.075926)

    address = location.first
    
    assert_equal 33.9986972, address.latitude
    assert_equal -118.0760384, address.longitude
    
    assert_equal address.longitude, address.lng
    assert_equal address.latitude, address.lat
  end
  
  def test_should_have_city
    stub_response! :reverse_locate_success
    location = @geo.locate(33.998671, -118.075926)
    address = location.first
    assert_equal "Pico Rivera", address.city
  end  
  
  def test_should_have_two_letter_state
    stub_response! :reverse_locate_success
    location = @geo.locate(33.998671, -118.075926)
    address = location.first
    assert_equal "CA", address.state
  end
  
  def test_should_have_zipcode
    stub_response! :reverse_locate_success
    location = @geo.locate(33.998671, -118.075926)
    address = location.first
    assert_equal "90660", address.zip
  end
  
  def test_should_have_country
    stub_response! :reverse_locate_success
    location = @geo.locate(33.998671, -118.075926)
    address = location.first
    assert_equal "US", address.country 
  end
  
  def test_should_have_full_address
    stub_response! :reverse_locate_success
    location = @geo.locate(33.998671, -118.075926)
    address = location.first
    assert_equal "4952-4958 Tobias Ave, Pico Rivera, CA 90660, USA", address.full_address
  end
  
  def test_should_raise_error_when_unknown_address
    stub_response! :reverse_locate_602
    assert_raise Google::Geo::UnknownAddressError do
      @geo.locate(0, 0)
    end
  end
end