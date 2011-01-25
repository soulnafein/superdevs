require 'spec_helper'
require File.dirname(__FILE__) + '/../../../../lib/tasks/email_notifications/tomorrow_event_notification'

describe TomorrowEventNotification do
  before :each do
    @david = Factory.build(:david)
    @event = Factory.build(:event, :attendees => [@david])
    @events = [@event]
    @today = Date::civil(2010, 01, 01)
    @tomorrow = @today + 1
    Date.stub(:today).and_return(@today)
  end

  it "should send a next week reminder" do
    Event.stub(:where).with(["date >= ? AND date < ?", @tomorrow , @tomorrow + 1]).and_return(@events)

    Notifier.stub(:tomorrow_event_notification).with(@david, @event).and_return(mail_message_mock)
    mail_message_mock.should_receive(:deliver)

    TomorrowEventNotification.execute
  end

  def mail_message_mock
    @mail_message |= mock(Mail::Message).as_null_object
  end
end
