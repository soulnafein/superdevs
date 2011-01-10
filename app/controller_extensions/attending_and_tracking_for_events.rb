module AttendingAndTrackingForEvents
  def attend
    load_event
    @event.register_attendee(current_user)
    FriendActivity.create!(:friend => current_user, :event => @event, :date => Time.now.utc)
    redirect_to event_path(@event.id)
  end

  def unattend
    load_event
    @event.unregister_attendee(current_user)
    redirect_to event_path(@event.id)
  end

  def track
    load_event
    @event.register_tracker(current_user)
    redirect_to event_path(@event.id)
  end

  def untrack
    load_event
    @event.unregister_tracker(current_user)
    redirect_to event_path(@event.id)
  end

  def login
    redirect_to event_path(params[:id])
  end
end