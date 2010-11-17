require 'spec_helper'

describe WeeklyEventNotification do
  before :each do
    @david = Factory(:david)
    @event = Factory(:event, :attendees => [@david])
    @events = [@event]
    @today = Date::civil(2010, 01, 01)
    @next_week = @today + 7
    Date.stub(:today).and_return(@today)
  end

  it "should send a next week reminder" do
    Event.stub(:where).with(["date >= ? AND date < ?", @next_week, @next_week + 1]).and_return(@events)

    Notifier.stub(:week_event_notification).with(@david, @event).and_return(mail_message_mock)
    mail_message_mock.should_receive(:deliver)

    WeeklyEventNotification.execute
  end

  def mail_message_mock
    @mail_message |= mock(Mail::Message).as_null_object
  end
end
