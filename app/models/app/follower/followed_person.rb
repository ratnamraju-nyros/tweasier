module App
  module Follower
    class FollowedPerson < Person
      
      named_scope :for_unfollower, :conditions => ["follower_people.mutual_follow = ? AND follower_people.created_at < ?", false, 3.days.ago]
      
    end
  end
end
