class Event < ActiveRecord::Base
  attr_accessible :title,
                  :city,
                  :country, 
                  :description, 
                  :link, 
                  :date,
                  :group

  has_many :attendances
  has_many :trackings
  has_many :attendees, :through => :attendances, :source => :user
  has_many :trackers, :through => :trackings, :source => :user
  include EventBehaviours::AttendingAndTracking

  belongs_to :group
  def is_organizer?(user)
    return false if group.nil?
    group.organizer?(user)
  end

  extend EventBehaviours::Queries
end
