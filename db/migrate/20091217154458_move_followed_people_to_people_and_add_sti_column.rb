class MoveFollowedPeopleToPeopleAndAddStiColumn < ActiveRecord::Migration
  def self.up
    rename_table :followed_people, :people
    add_column :people, :type, :string
  end

  def self.down
    rename_table :people, :followed_people
    remove_column :people, :type
  end
end
