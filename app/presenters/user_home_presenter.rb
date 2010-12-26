class UserHomePresenter
  def initialize(user)
    @user = user
  end

  def attended_or_tracked_events
    @attended_or_tracked_events ||=
            EventsListPresenter.new(Event.get_events_attended_or_tracked_by_user(@user), @user)
  end

  def friends_activities
    FriendActivity.latest_friends_activities_for_user(@user)
  end
end