class Event < ActiveRecord::Base
  def self.exists?(event)
    Event.where(:title => event.title,
                :date => event.date,
                :country => event.country).size > 0
  end

  def self.get_events_for_user(user)
    events = Event.where("country = ? and date > ?", user.country, Time.now).order("date ASC")
    events.where("city = 'London'")
  end
end
