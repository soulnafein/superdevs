class AttendancesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    Attendance.create(:user => current_user, :event => event)
    redirect_to(event_url(event), :notice => 'You are now attending this event.')
  end

  def destroy
    Attendance.delete(params[:id])
    event = Event.find(params[:event_id])
    redirect_to(event_url(event), :notice => 'You are not attending this event anymore.')
  end
end
