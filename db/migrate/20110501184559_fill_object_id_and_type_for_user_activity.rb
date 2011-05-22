class FillObjectIdAndTypeForUserActivity < ActiveRecord::Migration
  def self.up
    UserActivity.find_each do |ua|
      ua.object_id = ua.activity.event.id
      ua.object_type = Event.to_s
      ua.save!
    end
  end

  def self.down
  end
end
