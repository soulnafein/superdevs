require 'spec_helper'

describe "Event list view model used in several page when showing events" do
  it "should expose an event for each row" do
    events     = [Factory.build(:event, :id => 1),
                  Factory.build(:event, :id => 2),
                  Factory.build(:event, :id => 3)]

    view_model = EventListViewModel.new(events)

    view_model.rows[0].event.should == events[0]
    view_model.rows[1].event.should == events[1]
    view_model.rows[2].event.should == events[2]
  end

  it "should show date for first event of a day" do
    events     = [Factory.build(:event, :date => Time.utc(2010, 3, 12, 18, 30)),
                  Factory.build(:event, :date => Time.utc(2010, 3, 12, 20, 30)),
                  Factory.build(:event, :date => Time.utc(2010, 3, 15, 18, 30))]

    view_model = EventListViewModel.new(events)

    view_model.rows[0].show_date?.should be_true
    view_model.rows[1].show_date?.should be_false
    view_model.rows[2].show_date?.should be_true
  end
end