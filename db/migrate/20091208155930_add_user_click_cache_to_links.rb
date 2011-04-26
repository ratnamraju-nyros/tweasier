class AddUserClickCacheToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :cached_user_clickcount, :integer, :default => 0
  end

  def self.down
    remove_column :links, :cached_user_clickcount
  end
end
