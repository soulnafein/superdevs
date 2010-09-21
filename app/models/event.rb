class Event < ActiveRecord::Base
  has_many :attendances
  has_many :attendees, :through => :attendances, :source => :user

  def self.exists?(event)
    Event.where(:title => event.title,
                :date => event.date,
                :country => event.country).size > 0
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
    Event.where("upper(country) = ? and date > ?", user.country.to_s.upcase, Time.now).order("date ASC")
  end

  def has_attendee?(user)
    self.attendees.include?(user)
  end

  def attendance_for_user(user)
    self.attendances.where("user_id = ?", user.id).first
  end
end
