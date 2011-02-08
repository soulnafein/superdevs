class RenameTableFriendActivitiesToUserActivities < ActiveRecord::Migration
  def self.up
    rename_table :friend_activities, :user_activities
  end

  def self.down
    rename_table :user_activities, :friend_activities
  end
end
