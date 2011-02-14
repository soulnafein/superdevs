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

    def get_events_attended_or_tracked_by_user(user)
      attended_events_ids = Attendance.where('user_id = ?', user.id).map { |a| a.event_id }
      tracked_events_ids = Tracking.where('user_id = ?', user.id).map { |a| a.event_id }
      attended_or_tracked_events_id = (attended_events_ids | tracked_events_ids)
      Event.all_upcoming.where(:id => attended_or_tracked_events_id)
    end

    def all_upcoming
      Event.active_events.where("date >= ?", Time.now.utc.beginning_of_day).order("date ASC, title ASC")
    end

    def all_past
      Event.active_events.where("date < ?", Time.now.utc.beginning_of_day).order("date ASC, title ASC")
    end

    def united_kingdom
      Event.all_upcoming.where("upper(country) = 'UNITED KINGDOM'")
    end

    def active_events
      Event.where(:disabled => false)
    end
  end
end