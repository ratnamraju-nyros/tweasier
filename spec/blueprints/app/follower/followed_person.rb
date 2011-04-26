require 'machinist/active_record'
require 'sham'
require 'faker'

module App
  module Follower
    
    FollowedPerson.blueprint do
      user { Hashie::Mash.new(:screen_name => "bobby", :name => "Bobby", :friends_count=> 23, :favorites_count => 2, :followers_count => 3, :statuses_count => 3425) }
      search { App::Search.make }
      account { App::Account.make }
    end
    
  end
end
