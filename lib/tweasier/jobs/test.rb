module Tweasier
  module Jobs
    class Test
      @queue = :test
      
      def self.perform(id)
        sleep 10 # Simply tests a Resque job can run.
      end
      
    end
  end
end
