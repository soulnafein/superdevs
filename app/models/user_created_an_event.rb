class UserCreatedAnEvent
  def initialize(event)
    @event_id = event.id
    @group_id = event.group.id
  end

  def event
    Event.find(@event_id)
  end

  def group
    Group.find(@group_id)
  end

  def ==(other)
    self.event == other.event
  end
end
