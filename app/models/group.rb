class Group < ActiveRecord::Base
  has_friendly_id :unique_name
  belongs_to :organizer, :class_name => 'User'

  attr_accessible :description

  def members
    [self.organizer]
  end

  def self.find_active_by_unique_name(name)
    Group.all_active.where("unique_name = ?", name).
            first || (raise GroupNotFound)
  end

  def self.all_active
    Group.where("active = ?", true)
  end
end

class GroupNotFound < Exception
end
