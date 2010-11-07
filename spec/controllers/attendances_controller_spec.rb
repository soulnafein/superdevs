require 'spec_helper'

describe AttendancesController do
  include SessionTestHelper

  describe "attending an event" do
    before :each do
      @david = Factory(:david)
      logged_in_user_is(@david)
    end

    it "should add a user to the attendees of an event" do
      event = Factory(:event, :id => 12)
      Event.stub!(:find).with(event.id.to_s).and_return(event)
      Attendance.should_receive(:create).with(:event => event, :user => @david)

      post :create, {:event_id => '12'}

      response.should redirect_to event_path(event.id)
    end
  end

  describe "unattending an event" do
    before :each do
      @david = Factory(:david)
      logged_in_user_is(@david)

      @event = Factory(:event, :id => 12)
      Event.stub!(:find).with(@event.id.to_s).and_return(@event)
      @an_attendance = Factory(:attendance, :id => 1,  :user => @david)
    end

    it "should remove the attendance of a user" do
      Attendance.stub(:find).with(@an_attendance.id.to_s).and_return(@an_attendance)
      Attendance.should_receive(:delete).with(@an_attendance.id.to_s)

      delete :destroy, {:id => '1', :event_id => '12'}

      response.should redirect_to event_path(@event.id)
    end

    it "should not authorise removing attendances of other users" do
      attendance_of_other_user = Factory(:attendance, :id => 42, :event => @event, :user => Factory(:ken))

      Attendance.stub(:find).with(attendance_of_other_user.id).
              and_return(attendance_of_other_user)

      delete :destroy, {:id => 42, :event_id => '12'}
      response.status.should == 403
    end
  end

  describe "get attendees" do
    before :each do
      @david = Factory(:david)
      logged_in_user_is(@david)
    end

    it "should show list to organizer" do
      @current_user_group = Factory(:group, :id => 18, :organizer => @david)
      @event = Factory(:event, :id => 42, :group => @current_user_group)

      Event.stub(:find).with(@event.id).and_return(@event)

      get :index, :event_id => 42
      response.should be_success
    end

    it "should forbid non organizer to see the list" do
      @ken = Factory(:ken)
      another_user_group = Factory(:group, :id => 42, :organizer => @ken)
      @event = Factory(:event, :id => 42, :group => another_user_group)

      Event.stub(:find).with(@event.id).and_return(@event)
 
      get :index, :event_id => @event.id
      response.status.should == 403
    end
  end
end
