class AddActivityToUserActivity < ActiveRecord::Migration
  def self.up
    add_column :user_activities, :activity, :text
    UserActivity.find_each do |ua|
      ua.activity = UserIsAttendingAnEvent.new(ua.event)
      ua.save!
    end
  end

  def self.down
    remove_column :user_activities, :activity
  end
end
