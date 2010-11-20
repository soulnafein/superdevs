class TomorrowEventNotification
  def self.execute
    tomorrow = Date.today + 1

    events = Event.where(["date >= ? AND date < ?", tomorrow, tomorrow + 1])
    events.each do |event| 
      event.attendees.each do |user|
         Notifier.tomorrow_event_notification(user, event).deliver
      end
    end
  end
end
