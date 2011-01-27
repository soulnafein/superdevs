class WeeklyEventNotification
  def self.execute
    next_week = Date.today + 7

    events = Event.where(["date >= ? AND date < ?", next_week, next_week + 1])
    events.each do |event| 
      event.attendees.each do |user|
         Notifier.week_event_notification(user, event).deliver
      end
    end
  end
end
