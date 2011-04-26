class CreateFeedbackEntries < ActiveRecord::Migration
  def self.up
    create_table :feedback_entries do |t|
      t.text :content
      t.references :user
      t.timestamps
    end
    
  end

  def self.down
    drop_table :feedback_entries
  end
end
