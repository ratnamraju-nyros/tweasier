class AddProcessorToSearchConditionType < ActiveRecord::Migration
  def self.up
    add_column :search_condition_types, :processor, :string
  end

  def self.down
    remove_column :search_condition_types, :processor
  end
end
