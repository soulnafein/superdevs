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
      it "should send to the page the user home presenter" do
        user_home_presenter = stub(:user_home_presenter)
        UserHomePresenter.stub!(:new).with(@user).and_return(user_home_presenter)

        get 'index'

        assigns[:user_home_presenter].should == user_home_presenter
      end

    end
  end
end
