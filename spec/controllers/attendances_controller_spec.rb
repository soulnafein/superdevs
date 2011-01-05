require 'spec_helper'

describe AttendancesController do
  include SessionTestHelper

  describe "get attendees" do
    before :each do
      @david = Factory.build(:david, :id => 1)
      logged_in_user_is(@david)
    end

    it "should show list to organizer" do
      @current_user_group = Factory.build(:group, :id => 18, :organizer => @david)
      @event = Factory.build(:event, :id => 42, :group => @current_user_group)

      Event.stub(:find).with(@event.id).and_return(@event)

      get :index, :event_id => 42
      response.should be_success
    end

    it "should forbid non organizer to see the list" do
      @ken = Factory.build(:ken, :id => 2)
      another_user_group = Factory.build(:group, :id => 42, :organizer => @ken)
      @event = Factory.build(:event, :id => 42, :group => another_user_group)

      Event.stub(:find).with(@event.id).and_return(@event)
 
      get :index, :event_id => @event.id
      response.status.should == 403
    end
  end
end
