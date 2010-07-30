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
      Event.stub!(:get_events_for_user_city).and_return([Event.new])
      
      get 'index'

      response.should be_success
      response.should render_template("user_home")
    end

    context "When showing events" do
      it "should provide events for the user city" do
        expected_events = [Event.new]
        Event.stub!(:get_events_for_user_city).with(mock_user).and_return(expected_events)

        get 'index'

        assigns[:user_events].should_not be_nil
        assigns[:user_events].events.should == expected_events
        assigns[:user_events].location.should == "London, United Kingdom"
      end

      it "should get events from the all country if there are not events for the user's city" do
        expected_events = [Event.new]
        Event.stub!(:get_events_for_user_city).with(mock_user).and_return([])
        Event.stub!(:get_events_for_user_country).with(mock_user).and_return(expected_events)

        get 'index'

        assigns[:user_events].should_not be_nil
        assigns[:user_events].events.should == expected_events
        assigns[:user_events].location.should == "United Kingdom"
      end

      it "should notify the page that events for the all country has been loaded" do
        
      end
    end

    private
    def mock_session
      session = mock_model(UserSession).as_null_object
      session.stub(:record).and_return(mock_user)
      @mock_session ||= session
    end

    def mock_user(stubs={})
      user = User.new(:username => 'dsantoro', :full_name => 'David Santoro',
                      :country => 'United Kingdom', :city => 'London')
      @mock_user ||= user
    end
  end
end
