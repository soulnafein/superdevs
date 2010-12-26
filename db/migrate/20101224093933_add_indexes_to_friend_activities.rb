class AddIndexesToFriendActivities < ActiveRecord::Migration
  def self.up
    add_index :friend_activities, :friend_id, :unique => false, :null => false
    add_index :friend_activities, :date, :unique => false, :null => false
  end

  def self.down
    remove_index :friend_activities, :friend_id
    remove_index :friend_activities, :date
  end
end
