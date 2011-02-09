class UserIsAttendingAnEvent
  def initialize(event)
    @event_id = event.id
  end

  def event
    Event.find(@event_id)
  end

  def ==(other)
    self.event == other.event
  end
end
