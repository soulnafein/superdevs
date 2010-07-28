class Event < ActiveRecord::Base
  def self.exists?(event)
    Event.where(:title => event.title,
                :date => event.date,
                :country => event.country).size > 0
  end

  def self.get_events_for_user(user)
    Event.where(:country => user.country).order('date ASC')
  end
end
