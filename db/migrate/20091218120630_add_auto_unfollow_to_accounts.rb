class AddAutoUnfollowToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :auto_unfollow, :boolean, :default => false
  end

  def self.down
    remove_column :accounts, :auto_unfollow
  end
end
