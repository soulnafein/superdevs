require 'spec_helper'

describe EventsController do
  before :each do
    UserSession.stub(:find).and_return(mock_session)
  end
  describe "GET 'show'" do
    it "should load the event from the database" do
      event = mock(:event)
      Event.stub(:find).with(42).and_return(event)

      get :show, :id => 42

      response.should be_success
      assigns(:event).should == event
    end

    it "should send back a 404 when give an invalid id" do
      get :show, :id => 666

      response.status.should == 404
    end
  end

  def mock_session
    session = mock(UserSession).as_null_object
    session.stub(:record).and_return(mock_user)
    @mock_session ||= session
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end
end
