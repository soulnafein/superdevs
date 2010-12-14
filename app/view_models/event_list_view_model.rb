class EventListViewModel
  def initialize(events)
    @rows = events.map {|event| EventListRow.new(event)}
    rows.each_cons(2) do |pair|
      pair[1].show_date = pair[0].event.date.to_date
    end
  end

  attr_reader :rows
end

class EventListRow
  def initialize(event)
    @event = event
  end

  attr_reader :event
  attr_accessor :show_date?
end
