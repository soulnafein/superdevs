module EventsHelper
#tipical url:
#http://www.google.com/calendar/event?action=TEMPLATE&dates=20110131T120000Z%2f20110131T130000Z&sprop=website%3ahttp%3a%2f%2fwww.meetup.com%2fLondonjavacommunity%2fcalendar%2f16021414%2f&text=Online+Monthly+Prize+Draw%3A+Packt+Publishing+&location=Packt+Publishing+Promotion+-+This+is+an+online+promotion+-+There+will+be+no+physical+meetup%2C+United+Kingdom&sprop=name:LJC+-+London+Java+Community&details=For+full+details%2C+including+the+address%2C+and+to+RSVP+see%3A%0Ahttp%3A%2F%2Fwww.meetup.com%2FLondonjavacommunity%2Fcalendar%2F16021414%2F%0ALJC+-+London+Java+Community%0APlease+note+this+is+an+online+monthly+prize+draw+and+no+actual+meeting+will+take+place.%0D%0A%0D%0A%5Burl%3Dhttp%3A%2F%2Fwww.packtpub.com%2F%5DPackt+Publishing+%5B%26hellip%3B
  def google_calendar_event_url(event)
    url_for "http://www.google.com/calendar/event?action=TEMPLATE&dates=#{to_iso_format(event.date)}/#{to_iso_format(event.date+2.hours)}&sprop=website:#{request.url}&text=#{event.title}&location=#{event.city}(#{event.country})&sprop=#{event.title}&details=#{event_calendar_details(event)}"
  end

  def event_to_ical(event)
    cal = Icalendar::Calendar.new
    cal.custom_property("METHOD","PUBLISH")
    cal_event = Icalendar::Event.new 
    cal_event.dtstart = to_iso_format(event.date)
    cal_event.dtend =  to_iso_format(event.date + 2.hours)
    cal_event.summary = "SuperDevs event: #{event.title}"
    cal_event.description = "#{event.description}\n#{event_calendar_details(event)}"
    cal_event.klass = "PUBLIC"       
    cal_event.location = event.city
    cal.add_event(cal_event)
    cal.to_ical
  end

  def to_iso_format(date)
    date.strftime("%Y%m%dT%H%M%SZ")
  end

private
  def event_calendar_details(event)
    "For full details and to track/follow this event check the event page #{event_url(event)} on Superdevs!"
  end
end
