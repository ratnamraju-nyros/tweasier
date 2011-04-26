require 'google/geo'

module Tweasier
  module Geolocation
    class Base
      class << self
        
        def locate(query)
          begin
            results = client.locate(query)
            
            # Returns an Address object or nil
            results and results.is_a?(Array) ? results.first : nil
          
          rescue Google::Geo::BadRequestError => error
            # Doesn't recognise address...
            HoptoadNotifier.notify error
            nil
          rescue Google::Geo::UnknownAddressError => error
            # Doesn't recognise address...
            HoptoadNotifier.notify error
            nil
          rescue => error
            # Catch all and notify...
            HoptoadNotifier.notify error
            nil
          end
        end
        
        def reverse_locate(lat, long)
          begin
            results = client.locate(long, lat)
            
            # Returns an Address object or nil
            results and results.is_a?(Array) ? results.first : nil
          rescue => error
            # Catch all and notify...
            HoptoadNotifier.notify error
            nil
          end
        end
        
        def client
          # TODO: move the API key to global config
          @client ||= Google::Geo.new("ABQIAAAA-eURyKhSLzwC3AewI3OdFhQLNg9bWT2-pdEz34bH9gru3A-k4xRYiXkAN38OSuEZBwbag76oQqkE8A")
        end
      end
    end
  end
end
