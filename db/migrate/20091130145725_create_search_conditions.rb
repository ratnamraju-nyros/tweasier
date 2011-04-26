class CreateSearchConditions < ActiveRecord::Migration
  def self.up
    create_table :search_conditions do |t|
      t.references :search_condition_type, :search
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop_table :search_conditions
  end
end
