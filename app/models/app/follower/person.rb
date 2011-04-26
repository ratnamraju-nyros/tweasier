module App
  module Follower
    class Person < ActiveRecord::Base
      set_table_name :follower_people
      serialize :user
      
      validates_presence_of :account, :user
      
      belongs_to :search,  :class_name => "App::Search",  :foreign_key => :search_id
      belongs_to :account, :class_name => "App::Account", :foreign_key => :account_id
      
      delegate :screen_name,
               :name,
               :followers_count,
               :statuses_count,
               :friends_count, :to => :user
      
      default_scope :order => "created_at DESC"
      
    end
  end
end
