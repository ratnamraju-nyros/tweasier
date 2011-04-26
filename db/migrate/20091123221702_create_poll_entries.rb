class CreatePollEntries < ActiveRecord::Migration
  def self.up
    create_table :poll_entries do |t|
      t.references :user, :poll_answer
      t.timestamps
    end
  end

  def self.down
    drop_table :poll_entries
  end
end
