class Event < ActiveRecord::Base
  attr_accessible :title,
                  :city,
                  :country, 
                  :description, 
                  :link, 
                  :date,
                  :group,
                  :disabled

  has_many :attendances
  has_many :trackings
  has_many :attendees, :through => :attendances, :source => :user
  has_many :trackers, :through => :trackings, :source => :user
  include EventBehaviours::AttendingAndTracking

  belongs_to :group
  def is_organizer?(user)
    Admin.user_admin?(user) || (group && group.organizer?(user))
  end

  acts_as_commentable

  def comments
    self.root_comments
  end

  extend EventBehaviours::Queries

  def deactivate!
    self.disabled = true
    self.save!
  end
end
