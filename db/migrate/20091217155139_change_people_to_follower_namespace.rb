class ChangePeopleToFollowerNamespace < ActiveRecord::Migration
  def self.up
    rename_table :people, :follower_people
  end

  def self.down
    rename_table :follower_people, :people
  end
end
