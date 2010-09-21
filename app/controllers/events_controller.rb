class EventsController < ApplicationController
  before_filter :require_user

  def show
    @event = Event.find(params[:id])
  rescue
    render_404
  end
end
