class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :unique_hash, :user_hash, :long_url, :short_url
      t.integer :cached_clickcount, :default => 0
      t.references :account
      t.text :referrers
      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
