class Group < ActiveRecord::Base
  has_friendly_id :unique_name
  belongs_to :organizer, :class_name => 'User'
  has_many :events
  has_many :members, :through => :members, :source => :user

  attr_accessible :description

  def members
    @members = [] if @members.nil?
    [self.organizer] | @members
  end

  def organizer?(user)
    return false if user.nil?
    self.organizer.id == user.id
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
