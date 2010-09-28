class EventsGroupedByPeriod
  def initialize(events, today)
    @events = events
    @today = today
    @tomorrow = today.tomorrow
  end

  def todays_events
    @events.find_all { |e| e.date.to_date == @today.to_date }
  end

  def tomorrows_events
    @events.find_all { |e| e.date.to_date == @tomorrow.to_date }
  end

  def all_other_events
    @events - todays_events - tomorrows_events
  end
end