require 'spec_helper'
 
describe EventsController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do 
    it "should be successful" do
      Event.stub(:find).with(42).and_return(mock_event)
      get :show, :id => 42
      response.should be_success
      assigns(:event).should == mock_event
    end
  end

  describe "POST 'create'" do
    it "should save event" do
      Event.stub(:new).and_return(mock_event)
      mock_event.should_receive(:save!)
      valid_post = {:event => {:title => "Geek night", :city => "London", :country => "United Kingdom", :description => "A geek night", :date=>"10-10-2010"}}

      post :create, valid_post

      response.should redirect_to("/events/#{mock_event.id}")
    end
  end

  def mock_event(stubs={})
    @mock_event ||= mock_model(Event, stubs).as_null_object
  end
end
