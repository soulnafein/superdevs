class TomorrowEventNotification
  def self.execute
    next_week = Date.today + 1

    events = Event.where(["date >= ? AND date < ?", next_week, next_week + 1])
    events.each do |event| 
      event.attendees.each do |user|
         Notifier.tomorrow_event_notification(user, event).deliver
      end
    end
  end
end
