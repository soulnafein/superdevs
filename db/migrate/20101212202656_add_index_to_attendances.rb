class AddIndexToAttendances < ActiveRecord::Migration
  def self.up
    add_index :attendances, :user_id, :unique => false, :null => false
    add_index :attendances, :event_id, :unique => false, :null => false
    add_index :relationships, :follower_id, :unique => false, :null => false
    add_index :relationships, :followed_id, :unique => false, :null => false
  end

  def self.down
    remove_index :attendances, :user_id
    remove_index :attendances, :event_id
    remove_index :relationships, :follower_id
    remove_index :relationships, :followed_id
  end
end
