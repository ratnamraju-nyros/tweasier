module Tweasier
  module Jobs
    class AutoFollow
      @queue = :auto_follower
      
      class << self
        def perform(id)
          Tweasier::Follower::Base.new(id).run!
        end
      end
      
    end
  end
end
