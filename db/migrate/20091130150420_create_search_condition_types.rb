class CreateSearchConditionTypes < ActiveRecord::Migration
  def self.up
    create_table :search_condition_types do |t|
      t.string :operator, :label
      t.boolean :value_required, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :search_condition_types
  end
end
