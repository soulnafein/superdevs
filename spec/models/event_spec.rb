require 'spec_helper'

describe Event do
  it "should have many attendees" do
    event = Event.new
    event.attendees.size.should == 0
  end

  it "should tell me whether a user is attending an event" do
    an_attendee = Factory.create(:david, :id => 1)

    event = Event.new
    event.id = 4
    event.attendees.push(an_attendee)

    a_stranger = Factory.build(:ken, :id => 2)

    event.has_attendee?(an_attendee).should be_true
    event.has_attendee?(a_stranger).should be_false
  end

  it "should tell me whether a user is tracking an event" do
    a_tracker = Factory.create(:david, :id => 1)

    event = Event.new
    event.trackers.push(a_tracker)

    a_stranger = Factory.build(:ken)

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

  it "should register an attendee for the event" do
    david = Factory.create(:david)
    event = Event.new
    5.times { event.register_attendee(david) }
    event.attendees.length.should == 1
    event.has_attendee?(david).should be_true
  end

  it "should unregister an attendee of the event" do
    david, ken = Factory.create(:david), Factory.create(:ken)
    event = Factory.build(:event, :attendees => [david, ken])
    event.unregister_attendee(david)
    event.attendees.length.should == 1
    event.has_attendee?(david).should be_false
  end

  it "should register a tracker for the event" do
    david = Factory.create(:david, :id => 1)
    event = Event.new
    5.times { event.register_tracker(david) }
    event.trackers.length.should == 1
    event.has_tracker?(david).should be_true
  end

  it "should unregister a tracker of the event" do
    david, ken = Factory.build(:david, :id => 1), Factory.build(:ken, :id => 2)
    event = Factory.build(:event, :trackers => [david, ken])
    event.unregister_tracker(david)
    event.trackers.length.should == 1
    event.has_attendee?(david).should be_false
  end

  it "should list the attendees followed by a user" do
    david, ken, stranger = Factory.create(:david), Factory.create(:ken), Factory.create(:stranger)
    david.start_following(ken)
    event_attended_by_friend = Factory.build(:event, :attendees => [ken, stranger])
    event_attended_by_friend.attendees_followed_by(david).should == [ken]

    event_with_stranger = Factory.build(:event, :attendees => [stranger])
    event_with_stranger.attendees_followed_by(david).should == []
  end

  it "should list the trackers followed by a user" do
    david, ken, stranger = Factory.create(:david, :id => 1), Factory.create(:ken, :id => 2), Factory.create(:stranger, :id => 3)
    david.start_following(ken)
    event_attended_by_friend = Factory.build(:event, :trackers => [ken, stranger])
    event_attended_by_friend.attendees_followed_by(david).should == [ken]

    event_with_stranger = Factory.build(:event, :trackers => [stranger])
    event_with_stranger.attendees_followed_by(david).should == []
  end
end
