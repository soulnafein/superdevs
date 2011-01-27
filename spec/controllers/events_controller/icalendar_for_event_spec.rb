require 'spec_helper'

describe EventsController, "icalendar for event" do
  include SessionTestHelper

  before :each do
  end
  
  it "should render the page correctly" do
    event = Factory.build(:event, :id => 12)
    Event.stub!(:find).with(event.id.to_s).and_return(event)

    get :icalendar, {:id => '12'}
    response.should be_success
  end
end
