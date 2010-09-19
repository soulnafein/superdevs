class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
  rescue
    render_404
  end
end
