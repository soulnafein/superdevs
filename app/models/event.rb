class Event < ActiveRecord::Base
  has_many :attendances
  has_many :attendees, :through => :attendances, :source => :user
  belongs_to :group

  attr_accessible :title, 
                  :city,
                  :country, 
                  :description, 
                  :link, 
                  :date,
                  :group

  def has_attendee?(user)
    self.attendees.include?(user)
  end

  def attendance_for_user(user)
    self.attendances.where("user_id = ?", user.id).first
  end

  def self.exists?(event)
    Event.where("title = ? and date = ? and country = ?",
                event.title, event.date, event.country).size > 0
  end

  def self.get_events_for_user(user)
    events = get_events_for_user_city(user)
    events = get_events_for_user_country(user) if events.empty?
    events
  end

  def self.get_events_for_user_city(user)
    get_events_for_user_country(user).where("upper(city) = ?", user.city.to_s.upcase)
  end

  def self.get_events_for_user_country(user)
    Event.all_upcoming.where("upper(country) = ?", user.country.to_s.upcase)
  end

  def self.all_upcoming
    Event.where("date > ?", Time.now).order("date ASC")
  end

  def self.united_kingdom
    Event.all_upcoming.where("upper(country) = 'UNITED KINGDOM'")
  end

  def self.all_past
    Event.where("date < ?", Time.now).order("date ASC")
  end

  def has_attendee?(user)
    self.attendees.include?(user)
  end

  def attendance_for_user(user)
    self.attendances.where("user_id = ?", user.id).first
  end

  def is_organizer?(user)
    return false if group.nil?
    group.organizer?(user)
  end
end
