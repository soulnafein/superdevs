class AttendancesController < ApplicationController
  before_filter :load_event
  before_filter :require_user

  def create
    Attendance.create(:user => current_user, :event => @event)
    redirect_to_event_with_notice('You are now attending this event.')
  end

  def destroy
    if user_is_allowed_to_delete_attendance
      Attendance.delete(params[:id])
      redirect_to_event_with_notice('You are no longer attending this event.')
    else
      render_unauthorised_access
    end
  end

  private
  def load_event
    @event = Event.find(params[:event_id])
  end

  def redirect_to_event_with_notice(notice)
    redirect_to(event_url(@event), :notice => notice)
  end

  def user_is_allowed_to_delete_attendance
    attendance = Attendance.find(params[:id])
    attendance.user.id == current_user.id
  end
end
