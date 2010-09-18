# == Schema Information
#
# Table name: events
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  city        :string(255)
#  country     :string(255)
#  description :text
#  link        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  date        :datetime
#

class Event < ActiveRecord::Base
  attr_accessible :title, 
                  :city,
                  :country, 
                  :description, 
                  :link, 
                  :date

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
end
