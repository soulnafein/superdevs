require 'spec_helper'

describe "User homepage with updates, followers and so on" do
  it "should show all the upcoming evens that the user is attending" do
    user = Factory.build(:user)
    expected_events = [Factory.build(:event)]
    Event.stub(:get_events_attended_or_tracked_by_user).with(user).and_return(expected_events)
    events_list_presenter = stub(:event_list_presenter)
    EventsListPresenter.stub(:new).with(expected_events, user).and_return(events_list_presenter)

    presenter = UserHomePresenter.new(user)

    presenter.attended_or_tracked_events.should_not be_nil
    presenter.attended_or_tracked_events.should == events_list_presenter
  end
end

