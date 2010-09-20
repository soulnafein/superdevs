require 'spec_helper'

describe Event do
  it "should have many attendees" do
    event = Event.new
    event.attendees.size.should == 0
  end
end
