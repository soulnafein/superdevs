require 'spec_helper'

describe "User homepage with updates, followers and so on" do
  before :each do
    @current_user = Factory.build(:user)
  end

  it "should show all the upcoming evens that the user is attending" do
    expected_events = [Factory.build(:event)]
    Event.stub(:get_events_attended_or_tracked_by_user).with(@current_user).and_return(expected_events)
    events_list_presenter = stub(:event_list_presenter)
    EventsListPresenter.stub(:new).with(expected_events, @current_user).and_return(events_list_presenter)

    presenter = UserHomePresenter.new(@current_user)

    presenter.attended_or_tracked_events.should_not be_nil
    presenter.attended_or_tracked_events.should == events_list_presenter
  end

  it "should show the latests updates for the current user" do
    expected_friends_activities = [Factory.build(:friend_activity), Factory.build(:friend_activity)]

    FriendActivity.stub(:latest_friends_activities_for_user).with(@current_user).
            and_return(expected_friends_activities)

    presenter = UserHomePresenter.new(@current_user)

    presenter.friends_activities.should_not be_nil
    presenter.friends_activities.should == expected_friends_activities
  end
end

