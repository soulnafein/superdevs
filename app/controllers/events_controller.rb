require 'icalendar'

class EventsController < ApplicationController
  before_filter :require_user, :only => [:new, :create, :edit, :attend, :unattend, :track, :untrack, :login]

  def new
    group = Group.find_active_by_unique_name(params[:group_id])
    if group.organizer?(current_user)
      @event = Event.new(:group => group)
    else
      render_unauthorised_access
    end
  end

  def create
    group_id = params[:group_id]
    group = Group.find_active_by_unique_name(group_id)
    if group.organizer?(current_user)
      group.create_event(params[:event])
      redirect_to group_url(group.unique_name),
                  :notice => 'Event created'
    else
      render_unauthorised_access
    end
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  def edit
    load_event
    unless @event.is_organizer?(current_user)
      render_unauthorised_access
    end
  end

  def update
    load_event
    if @event.is_organizer?(current_user)
      @event.update_attributes!(params[:event])
      redirect_to group_event_url(@event.group.unique_name, @event.id)
    else
      render_unauthorised_access
    end
  end

  def show
    load_event
  rescue
    render_404
  end

  def index
    today = Date.today
    @events = EventsGroupedByPeriodPresenter.new(Event.united_kingdom, today)
  end

  def deactivate
    if Admin.user_admin?(current_user)
      load_event
      @event.deactivate!
      redirect_to events_url
    else
      render_unauthorised_access
    end
  end

  def icalendar
    @event = Event.find(params[:id])

    send_data(event_to_ical(@event),
              :type => 'text/calendar',
              :disposition => "inline; filename=event#{@event.id}.vcs", :filename=>"event#{@event.id}.vcs")
  end

  include AttendingAndTrackingForEvents
  include EventsHelper

 private
  def load_event
    @event = Event.find(params[:id])
  end
end
