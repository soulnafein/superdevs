class AddIndexToAttendances < ActiveRecord::Migration
  def self.up
    add_index :attendances, :user_id, :unique => false, :null => false
  end

  def self.down
    remove_index :attendances, :user_id
  end
end
