require 'spec_helper'

describe "Event list view model used in several page when showing events" do
  it "should expose an event for each row" do
    events     = [Factory.build(:event, :id => 1),
                  Factory.build(:event, :id => 2),
                  Factory.build(:event, :id => 3)]

    view_model = EventsListPresenter.new(events, nil)

    view_model.rows[0].event.should == events[0]
    view_model.rows[1].event.should == events[1]
    view_model.rows[2].event.should == events[2]
  end

  it "should only show date for first event of a day" do
    events     = [Factory.build(:event, :date => Time.utc(2010, 3, 12, 18, 30)),
                  Factory.build(:event, :date => Time.utc(2010, 3, 12, 20, 30)),
                  Factory.build(:event, :date => Time.utc(2010, 3, 15, 18, 30))]

    view_model = EventsListPresenter.new(events, nil)

    view_model.rows[0].show_date?.should be_true
    view_model.rows[1].show_date?.should be_false
    view_model.rows[2].show_date?.should be_true
  end

  context "When generating the attending and tracking friends info message" do
    before :each do
      @current_user = Factory(:user)
    end

    it "should be empty for 0 friends" do
      event_with_no_friends = stub(:event_with_no_friend)
      event_with_no_friends.stub(:attendees_followed_by).with(@current_user).and_return([])

      events = [event_with_no_friends]
      view_model = EventsListPresenter.new(events, @current_user)

      view_model.rows[0].attending_or_tracking_friends_info.should ==
              ""
    end

    it "should be singular for 1 friends" do
      david = Factory.build(:david)
      event_with_one_friend = stub(:event_with_one_friend)
      event_with_one_friend.stub(:attendees_followed_by).with(@current_user).and_return([david])

      events = [event_with_one_friend]
      view_model = EventsListPresenter.new(events, @current_user)

      view_model.rows[0].attending_or_tracking_friends_info.should ==
              "1 person you are following is attending or tracking"
    end

    it "should be plural for 2 or more friends" do
      david, ken = [Factory.build(:david), Factory.build(:ken)]
      event_with_two_friends = stub(:event_with_many_friends)
      event_with_two_friends.stub(:attendees_followed_by).with(@current_user).and_return([david, ken])

      events = [event_with_two_friends]
      view_model = EventsListPresenter.new(events, @current_user)

      view_model.rows[0].attending_or_tracking_friends_info.should ==
              "2 people you are following are attending or tracking"

    end
  end

  it "should provide a list of friends attending or tracking" do
    david, ken = [Factory.build(:david), Factory.build(:ken)]
    current_user = Factory.build(:user)
    event_with_two_friends = stub(:event_with_many_friends)
    event_with_two_friends.stub(:attendees_followed_by).with(current_user).and_return([david, ken])

    events = [event_with_two_friends]
    view_model = EventsListPresenter.new(events, current_user)

    view_model.rows[0].attending_or_tracking_friends.should == [david, ken]
  end

  it "should show admin actions when an admin access the page" do
    david, ken = [Factory.build(:david, :id => 1), Factory.build(:ken, :id => 2)]
    Admin.stub!(:user_admin?).with(david).and_return(true)
    Admin.stub!(:user_admin?).with(ken).and_return(false)

    view_model_for_david = EventsListPresenter.new([Factory.build(:event)], david)
    view_model_for_ken = EventsListPresenter.new([Factory.build(:event)], ken)

    view_model_for_david.show_admin_actions?.should be_true
    view_model_for_ken.show_admin_actions?.should be_false
  end
end