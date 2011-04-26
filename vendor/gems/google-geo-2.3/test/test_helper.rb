here = File.dirname __FILE__

["vendor/mocha-0.4.0/lib", "lib"].each do |path|
  p = "#{here}/../#{path}"
  $:.unshift p unless $:.include? p
end

require "test/unit"
require "mocha"
require "google/geo"

begin; require "rubygems"; require "redgreen"; rescue LoadError; end

class Test::Unit::TestCase
  def response(filename)
    File.open "#{File.dirname __FILE__}/fixtures/#{filename}.xml"
  end
  
  def stub_response!(name)
    Google::Geo::Response.any_instance.
      expects(:open).returns(response(name))
  end
end
