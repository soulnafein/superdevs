class EventsController < ApplicationController
  before_filter :require_user, :only => [:new, :create] 
  def new
    @event = Event.new
  end

  def show 
    @event = Event.find(params[:id])
  rescue
    render_404
  end

  def create
    @event = Event.new(params[:event])
    @event.save!
    redirect_to @event
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  def index
    today = Date.today
    @events = EventsGroupedByPeriod.new(Event.all_upcoming, today)
  end
end
