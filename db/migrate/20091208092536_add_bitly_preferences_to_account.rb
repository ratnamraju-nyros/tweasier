class AddBitlyPreferencesToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :bitly_token, :string
    add_column :accounts, :bitly_secret, :string
  end

  def self.down
    remove_column :accounts, :bitly_token
    remove_column :accounts, :bitly_secret
  end
end
