module Tweasier
  module Geolocation
    module Helpers
      def self.included(base)
        base.send :include, InstanceMethods
      end
      
      module InstanceMethods
        def address_from_geolocation(geolocation)
          return "" unless geolocation and geolocation.coordinates
          
          lat  = geolocation.coordinates[0]
          long = geolocation.coordinates[1]
          
          result = Tweasier::Geolocation::Base.reverse_locate(lat, long)
          
          # Lets only return the city for now as security
          result and result.respond_to?(:full_address) ? result.city : ""
        end
      end
    end
  end
end
