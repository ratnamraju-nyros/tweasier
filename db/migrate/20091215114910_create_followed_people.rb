class CreateFollowedPeople < ActiveRecord::Migration
  def self.up
    create_table :followed_people do |t|
      t.references :search, :account
      t.text :user
      t.timestamps
    end
  end

  def self.down
    drop_table :followed_people
  end
end
