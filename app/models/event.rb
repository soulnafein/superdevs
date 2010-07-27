class Event < ActiveRecord::Base
  def self.exists?(event)
    Event.where(:title => event.title,
                :date => event.date,
                :country => event.country).size > 0
  end
end
