class Group < ActiveRecord::Base
  has_friendly_id :unique_name
  belongs_to :organizer, :class_name => 'User'

  def self.find_active_by_unique_name(name)
    Group.where("active = ? and unique_name = ?", true, name).
            first || (raise GroupNotFound)
  end
end

class GroupNotFound < Exception
end
