class UserSessionsController < ApplicationController
  def new
    @user_session = PersonSession.new
  end

  def create
    @user_session = PersonSession.new(params[:person_session])
    @user_session.save!
    redirect_to root_url, :notice => "Successfully logged in"
  rescue Authlogic::Session::Existence::SessionInvalidError
    render :action => :new
  end

  def destroy
    @user_session = PersonSession.find
    @user_session.destroy
    redirect_to root_url, :notice => "Successfully logged out"
  end
end
