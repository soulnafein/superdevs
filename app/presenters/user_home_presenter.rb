class UserHomePresenter
  def initialize(user)
    @user = user
  end

  def attended_or_tracked_events
    @attended_or_tracked_events ||=
            EventsListPresenter.new(Event.get_events_attended_or_tracked_by_user(@user), @user)
  end

  def friends_activities
    UserActivity.latest_friends_activities_for_user(@user)
  end

  def template_for_activity(activity)
    "shared/user_activities/#{activity.class.to_s.underscore}"
  end
end