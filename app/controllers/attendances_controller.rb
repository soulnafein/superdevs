class AttendancesController < ApplicationController
  before_filter :load_event
  before_filter :require_user

  def index
    if @event.is_organizer?(current_user)
      @attendees = @event.attendees
    else
      render_unauthorised_access
    end
  end 

  private
  def load_event
    @event = Event.find(params[:event_id])
  end
end
