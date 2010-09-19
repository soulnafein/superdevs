require 'spec_helper'

describe EventsController do
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
end
