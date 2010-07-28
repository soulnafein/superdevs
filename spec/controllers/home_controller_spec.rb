require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  context "When the visitor is logged in" do
    before :each do
      UserSession.stub(:find).and_return(mock_session)
    end

    it "should show a personalised home page" do
      Event.stub!(:get_events_for_user).and_return([])
      
      get 'index'

      response.should be_success
      response.should render_template("user_home")
    end

    it "should load a set of personalised events" do
      expected_events = [Event.new]
      Event.stub!(:get_events_for_user).with(mock_user).and_return(expected_events)

      get 'index'

      assigns[:events].should_not be_nil
      assigns[:events].should == expected_events
    end

    private
    def mock_session
      session = mock_model(UserSession).as_null_object
      session.stub(:record).and_return(mock_user)
      @mock_session ||= session
    end

    def mock_user(stubs={})
      @mock_user ||= mock_model(User, stubs).as_null_object
    end
  end
end
