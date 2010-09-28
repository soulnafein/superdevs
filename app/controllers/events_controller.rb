class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
  rescue
    render_404
  end

  def index
    today = Date.today
    @events = EventsGroupedByPeriod.new(Event.all_upcoming, today)
  end
end
