module App
  module Follower
    class UnfollowedPerson < Person
      
      default_scope :order => "updated_at DESC"
      
    end
  end
end
