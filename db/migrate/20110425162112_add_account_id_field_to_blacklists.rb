class AddAccountIdFieldToBlacklists < ActiveRecord::Migration
  def self.up
    add_column :blacklists, :account_id, :integer
  end

  def self.down
    remove_column :blacklists, :account_id
  end
end
