require 'spec_helper'

describe EventsController, "Tracking and Untracking an event" do
  include SessionTestHelper

  before :each do
    @david = Factory(:david)
    logged_in_user_is(@david)
  end

  it "should add a user to the trackers of an event" do
    event = Factory(:event, :id => 12)
    Event.stub!(:find).with(event.id.to_s).and_return(event)
    event.should_receive(:register_tracker).with(@david)

    get :track, {:id => '12'}

    response.should redirect_to event_path(event.id)
  end

  it "should remove a user from the trackers of an event" do
    event = Factory(:event, :id => 12)
    Event.stub!(:find).with(event.id.to_s).and_return(event)
    event.should_receive(:unregister_tracker).with(@david)

    get :untrack, {:id => '12'}

    response.should redirect_to event_path(event.id)
  end
end
