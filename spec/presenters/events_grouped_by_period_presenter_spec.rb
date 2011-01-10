require 'spec_helper'

describe EventsGroupedByPeriodPresenter do
  before :each do
    @today = Chronic.parse("14 March 2010")
    @tomorrow = Chronic.parse("15 March 2010")
    @other_events = [Event.new(:date => Chronic.parse("20 March 2010")),
                    Event.new(:date => Chronic.parse("3 January 2011"))]
  end

  it "should give me the events for today" do
    todays_events = [Event.new(:date => @today), Event.new(:date => @today)]
    all_events = todays_events + @other_events

    grouped_events = EventsGroupedByPeriodPresenter.new(all_events, @today)

    grouped_events.todays_events.size.should == 2
    grouped_events.todays_events[0].date.should == @today
    grouped_events.todays_events[1].date.should == @today
  end

  it "should give me the events for tomorrow" do
    tomorrow_events = [Event.new(:date => @tomorrow),
                       Event.new(:date => @tomorrow)]
    all_events = tomorrow_events + @other_events

    grouped_events = EventsGroupedByPeriodPresenter.new(all_events, @today)

    grouped_events.tomorrows_events.size.should == 2
    grouped_events.tomorrows_events[0].date.should == @tomorrow
    grouped_events.tomorrows_events[1].date.should == @tomorrow
  end

  it "should give me all the other upcoming events" do
    todays_events = [Event.new(:date => @today), Event.new(:date => @today)]
    tomorrows_events = [Event.new(:date => @tomorrow),
                       Event.new(:date => @tomorrow)]
    all_events = todays_events + tomorrows_events + @other_events

    grouped_events = EventsGroupedByPeriodPresenter.new(all_events, @today)

    all_other_events = grouped_events.all_other_events
    all_other_events.size.should == 2
    all_other_events[0].date.should == Chronic.parse("20 March 2010")
    all_other_events[1].date.should == Chronic.parse("3 January 2011")
  end
end
