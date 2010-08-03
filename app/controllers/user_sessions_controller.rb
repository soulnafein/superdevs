class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  protect_from_forgery :except => [:create]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
    if @user_session.new_registration?
      flash[:notice] = "Welcome! As a new user, please review your registration details before continuing.."
      redirect_to edit_mandatory_details_url
    else
      if @user_session.registration_complete?
        flash[:notice] = "Successfully signed in."
        redirect_to root_url, :notice => "Successfully logged in"
      else
        flash[:notice] = "Welcome back! Please complete required registration details before continuing.."
        redirect_to edit_mandatory_details
      end
    end
  #rescue Authlogic::Session::Existence::SessionInvalidError
  else
    flash[:error] = "Failed to login or register."
    render :action => :new
  end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    redirect_to login_url, :notice => "Successfully logged out"
  end
end
