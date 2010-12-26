class CreateFriendActivities < ActiveRecord::Migration
  def self.up
    create_table :friend_activities do |t|
      t.references :friend
      t.references :event
      t.datetime :date

      t.timestamps
    end
  end

  def self.down
    drop_table :friend_activities
  end
end
