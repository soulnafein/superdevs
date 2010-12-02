require 'spec_helper'

describe HomeController do
  include SessionTestHelper

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  context "When the visitor is logged in" do
    before :each do
      @user = Factory(:user)
      logged_in_user_is(@user)
      @expected_events = [Factory(:event)]
    end

    it "should show a personalised home page" do
      Event.stub!(:get_events_for_user_city).and_return(@expected_events)
      
      get 'index'

      response.should be_success
      response.should render_template("user_home")
    end

    context "When showing events" do
      it "should provide events for the user city" do
        Event.stub!(:get_events_for_user_city).with(@user).and_return(@expected_events)

        get 'index'

        assigns[:user_events].should_not be_nil
        assigns[:user_events].events.should == @expected_events
        assigns[:user_events].location.should == "London, United Kingdom"
      end

      it "should get events from the all country if there are not events for the user's city" do
        Event.stub!(:get_events_for_user_city).with(@user).and_return([])
        Event.stub!(:get_events_for_user_country).with(@user).and_return(@expected_events)

        get 'index'

        assigns[:user_events].should_not be_nil
        assigns[:user_events].events.should == @expected_events
        assigns[:user_events].location.should == "United Kingdom"
      end

      it "should show all the upcoming evens that the user is attending" do
        Event.stub(:get_events_attended_by_user).with(@user).and_return(@expected_events)

        get 'index'

        assigns[:events_attended_by_user].should_not be_nil
        assigns[:events_attended_by_user].should == @expected_events
      end
    end
  end
end
