class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save!
    redirect_to user_path(@user_session.record), :notice => "Successfully logged in"
  rescue Authlogic::Session::Existence::SessionInvalidError
    render :action => :new
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    redirect_to login_url, :notice => "Successfully logged out"
  end
end
