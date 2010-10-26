class EventsController < ApplicationController
  before_filter :require_user, :only => [:new, :create, :edit]

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
    @event = Event.find(params[:id])
    unless @event.is_organizer?(current_user)
      render_unauthorised_access
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.is_organizer?(current_user)
      @event.update_attributes!(params[:event])
      redirect_to group_event_url(@event.group.unique_name, @event.id)
    else
      render_unauthorised_access
    end
  end

  def show
    @event = Event.find(params[:id])
  rescue
    render_404
  end

  def index
    today = Date.today
    @events = EventsGroupedByPeriod.new(Event.united_kingdom, today)
  end
end
