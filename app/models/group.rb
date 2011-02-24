class Group < ActiveRecord::Base
  has_friendly_id :unique_name
  belongs_to :organizer, :class_name => 'User'
  has_many :events
  has_many :membership
  has_many :members, :through => :membership, :source => :user

  attr_accessible :description

  def members_organizer
    @members = [] if @members.nil?
    [self.organizer] | @members
  end

  def organizer?(user)
    return false if user.nil?
    self.organizer.id == user.id
  end

  def member?(user)
    self.members.include?(user)
  end

  def past_events
    self.events.all_past
  end

  def upcoming_events
    self.events.all_upcoming
  end

  def membership_for_user(user)
    self.membership.where("user_id = ?", user.id).first
  end

  def self.find_active_by_unique_name(name)
    Group.all_active.where("unique_name = ?", name).
            first || (raise GroupNotFound)
  end

  def self.all_active
    Group.where("active = ?", true)
  end

  def create_event(params)
    event = Event.new(params)
    event.group = self
    event.save!
    event
  end
end

class GroupNotFound < Exception
end
