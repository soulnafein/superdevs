class Event < ActiveRecord::Base
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
    get_events_for_user_country(user).where("upper(city) = ?", user.city.upcase)
  end

  def self.get_events_for_user_country(user)
    Event.where("upper(country) = ? and date > ?", user.country.upcase, Time.now).order("date ASC")
  end
end
