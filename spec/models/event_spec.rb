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

  it "should tell me whether a user is tracking an event" do
    a_tracker = User.new
    a_tracker.id = 1

    event = Event.new
    event.trackers.push(a_tracker)

    a_stranger = User.new
    a_stranger.id = 2

    event.has_tracker?(a_tracker).should be_true
    event.has_tracker?(a_stranger).should be_false
  end

  it "should tell me whether a user is not an organiser for non group events" do
    a_user = User.new
    event = Event.new(:group => nil)
    event.is_organizer?(a_user).should be_false
  end

  it "should tell whether a user is the organizer of a group" do
    a_user = User.new do |u|
      u.id = 123
    end
    a_group = Group.new
    a_group.organizer = a_user
    event = Event.new(:group => a_group)
    event.is_organizer?(a_user).should be_true
  end


end
