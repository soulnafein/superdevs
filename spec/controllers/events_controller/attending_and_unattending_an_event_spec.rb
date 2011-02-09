require 'spec_helper'

describe EventsController, "Attending and Unattending an event" do
  include SessionTestHelper

  before :each do
    @david = Factory.build(:david)
    logged_in_user_is(@david)
  end

  it "should add a user to the attendees of an event" do
    event = Factory.build(:event, :id => 12)
    Event.stub!(:find).with(event.id.to_s).and_return(event)
    event.should_receive(:register_attendee).with(@david)

    get :attend, {:id => '12'}

    response.should redirect_to event_path(event.id)
  end

  it "should add an activity that declares the attendance to the event" do
    event = Factory.build(:event, :id => 12)
    Event.stub!(:find).with(event.id.to_s).and_return(event)
    Event.stub!(:find).with(event.id).and_return(event)
    stubbed_time = Time.now
    Time.stub(:now).and_return(stubbed_time)

    params = {:activity => UserIsAttendingAnEvent.new(event), :friend => @david, :date => stubbed_time.utc}

    UserActivity.should_receive(:create!).with(params)

    get :attend, {:id => '12'}
  end

  it "should remove a user from the attendees of an event" do
    event = Factory.build(:event, :id => 12)
    Event.stub!(:find).with(event.id.to_s).and_return(event)
    event.should_receive(:unregister_attendee).with(@david)

    get :unattend, {:id => '12'}

    response.should redirect_to event_path(event.id)
  end

end
