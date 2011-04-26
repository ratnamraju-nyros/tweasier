require 'twitter'

module Tweasier
  module Search    
    class Base
      attr_accessor :term
      
      def initialize(term)
        self.term = term
      end
      
      def run!(opts={})
        per_page = opts[:per_page] || 50
        
        opts.merge!(:user_agent => "Tweasier")
        
        search = Twitter::Search.new(self.term, opts).per_page(per_page).fetch.results
        search || []
      end
    end
  end
end
