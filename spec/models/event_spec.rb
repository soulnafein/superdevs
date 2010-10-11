require 'spec_helper'

describe Event do
  it "should have many attendees" do
    event = Event.new
    event.attendees.size.should == 0
  end

  it "should tell me whether a user is attending an event" do
    an_attendee = User.new
    an_attendee.id = 1

    event = Event.new
    event.attendees.push(an_attendee)

    a_stranger = User.new
    a_stranger.id = 2

    event.has_attendee?(an_attendee).should be_true
    event.has_attendee?(a_stranger).should be_false
  end

  it "should tell me whether a user is an organizer" do
    a_user = User.new
    event = Event.new(:group => nil)
    event.is_organizer?(a_user).should be_false
  end
end
