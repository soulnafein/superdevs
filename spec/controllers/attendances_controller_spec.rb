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
