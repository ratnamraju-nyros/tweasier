class AddAutoFollowPreferenceToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :auto_follow, :boolean, :default => true
  end

  def self.down
    remove_column :accounts, :auto_follow
  end
end
