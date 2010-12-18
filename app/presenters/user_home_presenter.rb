class UserHomePresenter
  def initialize(user)
    @user = user
  end

  def attended_or_tracked_events
    @attended_or_tracked_events ||=
            EventsListPresenter.new(Event.get_events_attended_or_tracked_by_user(@user), @user)
  end
end