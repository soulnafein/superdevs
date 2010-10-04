class EventsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]

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
      @event = Event.new(params[:event])
      @event.group = group
      @event.save!
      redirect_to group_url(group.unique_name),
                  :notice => 'Event created'
    else
      render_unauthorised_access
    end
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

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
