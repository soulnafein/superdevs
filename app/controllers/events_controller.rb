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
    @events = EventsGroupedByPeriod.new(Event.united_kingdom, today)
  end

  def icalendar
    @event = Event.find(params[:id])

    cal = Icalendar::Calendar.new
    cal.custom_property("METHOD","PUBLISH")
    cal_event = Icalendar::Event.new 
    cal_event.dtstart = @event.date.strftime("%Y%m%dT%H%M%S")
    cal_event.dtend =  @event.date.since(3600).strftime("%Y%m%dT%H%M%S")
    cal_event.summary = "SuperDevs event: #{@event.title}"
    cal_event.description = "#{@event.description}\nNeed more info? check the event page(#{event_url(@event)}) on SuperDevs!"
    cal_event.klass = "PUBLIC"       
    cal_event.location = @event.city
    cal.add_event(cal_event)
    send_data(cal.to_ical, :type => 'text/calendar', :disposition => "inline; filename=event#{@event.id}.vcs", :filename=>"event#{@event.id}.vcs")
  end

  include AttendingAndTrackingForEvents

 private
  def load_event
    @event = Event.find(params[:id])
  end
end
