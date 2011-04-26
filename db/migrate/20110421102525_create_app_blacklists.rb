class CreateAppBlacklists < ActiveRecord::Migration
  def self.up
    create_table :blacklists do |t|
      
      t.string :screen_name 
      t.string :first_name 
    
    
      t.timestamps
    end
  end

  def self.down
    drop_table :app_blacklists
  end
end
