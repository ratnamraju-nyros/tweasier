module Tweasier
  module Cache
    class Base
      class << self
        # We convert to and from YAML as some objects cannot
        # be correctly serialised through MemCached.
        def get(key)
          (value = client.read(key)) ? YAML.load(value) : nil
        end
        
        def set(key, value, opts={})
          client.write(key, value.to_yaml, opts)
        end
        
        def exists?(key)
          client.exist?(key)
        end
        
        def expire!(key)
          client.delete(key)
        end
        alias_method :destroy, :expire!
        
        def client
          # Define the caching interface
          Rails.cache
        end
      end
    end
  end
end
