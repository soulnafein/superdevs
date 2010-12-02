module EventBehaviours
  module Queries
    def exists?(event)
      Event.where("title = ? and date = ? and country = ?",
                  event.title, event.date, event.country).size > 0
    end

    def get_events_for_user(user)
      events = get_events_for_user_city(user)
      events = get_events_for_user_country(user) if events.empty?
      events
    end

    def get_events_for_user_city(user)
      get_events_for_user_country(user).where("upper(city) = ?", user.city.to_s.upcase)
    end

    def get_events_for_user_country(user)
      Event.all_upcoming.where("upper(country) = ?", user.country.to_s.upcase)
    end

    def get_events_attended_by_user(user)
      attended_events_ids = Attendance.where('user_id = ?', user.id).map { |a| a.event_id }
      Event.all_upcoming.find_all {|e| attended_events_ids.include?(e.id)}
    end

    def all_upcoming
      Event.where("date > ?", Time.now.beginning_of_day).order("date ASC")
    end

    def united_kingdom
      Event.all_upcoming.where("upper(country) = 'UNITED KINGDOM'")
    end

    def all_past
      Event.where("date < ?", Time.tomorrow).order("date ASC")
    end
  end
end