require 'spec_helper'

describe AttendancesController do
  describe "attending an event" do
    before :each do
      UserSession.stub(:find).and_return(mock_session)
    end

    it "should add a user to the attendees of an event" do
      event = Event.new(:title => 'A test event')
      event.id = 12
      Event.stub!(:find).with(event.id.to_s).and_return(event)
      Attendance.should_receive(:create).with(:event => event, :user => mock_user)

      post :create, {:event_id => '12'}

      response.should redirect_to event_path(event)
    end
  end

  describe "unattending an event" do
    before :each do
      UserSession.stub(:find).and_return(mock_session)
      @event = Event.new do |e|
        e.title = 'A test event'
        e.id = 12
      end
      Event.stub!(:find).with(@event.id.to_s).and_return(@event)
      @an_attendance = Attendance.new do |a|
        a.id = 54
        a.user = mock_user
        a.event = @event
      end
    end

    it "should remove the attendance of a user" do
      Attendance.stub(:find).with(@an_attendance.id).and_return(@an_attendance)
      Attendance.should_receive(:delete).with(@an_attendance.id)

      delete :destroy, {:id => @an_attendance.id, :event_id => '12'}

      response.should redirect_to event_path(@event)
    end

    it "should not authorise removing attendances of other users" do
      attendance_of_other_user = Attendance.new do |a|
        a.id = 42
        a.event = @event
        a.user = mock_model(User)
      end
      Attendance.stub(:find).with(attendance_of_other_user.id).
              and_return(attendance_of_other_user)

      delete :destroy, {:id => 42, :event_id => '12'}

      response.status.should == 403
    end
  end

  private
  def mock_session
    session = mock(UserSession).as_null_object
    session.stub(:record).and_return(mock_user)
    @mock_session ||= session
  end

  def mock_user(stubs={})
    user = User.new(:username => 'dsantoro', :full_name => 'David Santoro',
                    :country => 'United Kingdom', :city => 'London')
    @mock_user ||= user
  end
end
