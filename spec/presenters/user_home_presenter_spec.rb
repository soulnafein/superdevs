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
    expected_friends_activities = [Factory.build(:user_activity), Factory.build(:user_activity)]

    UserActivity.stub(:latest_friends_activities_for_user).with(@current_user).
            and_return(expected_friends_activities)

    presenter = UserHomePresenter.new(@current_user)

    presenter.friends_activities.should_not be_nil
    presenter.friends_activities.should == expected_friends_activities
  end
  
  it "should pick a different template based on the activity type" do
    presenter = UserHomePresenter.new(@current_user)
    
    presenter.template_for_activity(UserIsAttendingAnEvent.new(Factory(:event))).should ==
            "shared/user_activities/user_is_attending_an_event"
    presenter.template_for_activity(UserCreatedAnEvent.new(Factory(:event, :group => Factory(:group)))).should ==
            "shared/user_activities/user_created_an_event"
  end
end

