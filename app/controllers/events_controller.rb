class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def show 
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(params[:event])
    @event.save!
    redirect_to @event
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end
end
