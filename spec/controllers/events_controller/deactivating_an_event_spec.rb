require 'spec_helper'

describe EventsController, "Deactivating an event" do
  include SessionTestHelper

  before :each do
    @david = Factory.build(:david, :id => 1)
    @ken = Factory.build(:ken, :id => 2)
  end

  it "should allow deactivation of event when admin ask for it" do
    logged_in_user_is(@david)
    user_is_admin(@david)
    event = Factory.build(:event, :id => 12)
    Event.stub!(:find).with(event.id.to_s).and_return(event)
    event.should_receive(:deactivate!)

    get :deactivate, {:id => '12'}

    response.should redirect_to events_url
  end

  it "should not allow deactivation of event when user is not admin" do
    logged_in_user_is(@ken)

    get :deactivate, {:id => '12'}

    response.status.should == 403
  end
end
