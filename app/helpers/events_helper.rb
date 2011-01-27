module EventsHelper
#tipical url:
#http://www.google.com/calendar/event?action=TEMPLATE&dates=20110131T120000Z%2f20110131T130000Z&sprop=website%3ahttp%3a%2f%2fwww.meetup.com%2fLondonjavacommunity%2fcalendar%2f16021414%2f&text=Online+Monthly+Prize+Draw%3A+Packt+Publishing+&location=Packt+Publishing+Promotion+-+This+is+an+online+promotion+-+There+will+be+no+physical+meetup%2C+United+Kingdom&sprop=name:LJC+-+London+Java+Community&details=For+full+details%2C+including+the+address%2C+and+to+RSVP+see%3A%0Ahttp%3A%2F%2Fwww.meetup.com%2FLondonjavacommunity%2Fcalendar%2F16021414%2F%0ALJC+-+London+Java+Community%0APlease+note+this+is+an+online+monthly+prize+draw+and+no+actual+meeting+will+take+place.%0D%0A%0D%0A%5Burl%3Dhttp%3A%2F%2Fwww.packtpub.com%2F%5DPackt+Publishing+%5B%26hellip%3B
  def google_calendar_event_url(event)
    url_for "http://www.google.com/calendar/event?action=TEMPLATE&dates#{event.date.strftime("%Y%m%dT120000Z/%Y%m%dT130000Z")}&sprop=website:#{request.url}&text=#{event.title}&location=#{event.city}(#{event.country})&sprop=#{event.title}&details=For full detail and to track/follow this event see: #{request.host_with_port}"
  end
end
