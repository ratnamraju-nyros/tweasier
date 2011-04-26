class AddMutualFollowFlagToPerson < ActiveRecord::Migration
  def self.up
    add_column :follower_people, :mutual_follow, :boolean, :default => false
  end

  def self.down
    remove_column :follower_people, :mutual_follow
  end
end
