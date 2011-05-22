class AddObjectIdAndTypeToUserActivity < ActiveRecord::Migration
  def self.up
    rename_column :user_activities, :event_id, :object_id
    add_column :user_activities, :object_type, :string
  end

  def self.down
    rename_column :user_activities, :object_id, :event_id
    remove_column :user_activities, :object_type
  end
end
