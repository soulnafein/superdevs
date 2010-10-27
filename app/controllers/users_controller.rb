class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:edit, :follow, :edit_mandatory_details, :complete_registration, :update]

  def index
    @users = User.all_active_users
  end

  def show
    load_user
  end

  def edit
    load_user
  end

  def edit_mandatory_details
  end

  def complete_registration
    current_user.email = params[:user][:email]
    current_user.username = params[:user][:username].gsub(".", "")
    current_user.full_name = params[:user][:full_name]
    current_user.agreed_tc_and_pp = params[:user][:agreed_tc_and_pp]
    current_user.save!
    redirect_to(current_user, :notice => 'Registration complete.')
  rescue ActiveRecord::RecordInvalid
    render :action => :edit_mandatory_details
  end

  def update
    load_user
    @user.update_attributes!(params[:user])
    redirect_to(@user, :notice => 'Profile successfully updated.')
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.save!
    @user.deliver_activation_instructions!
    confirmation = url_for(:controller => :pages, :action => :invitation_requested)
    redirect_to confirmation, :status => 303
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  def addrpxauth
    @user = current_user
    if @user.save
      flash[:notice] = "Successfully added RPX authentication for this account."
      render :action => 'show'
    else
      render :action => 'edit'
    end
  end

  #TODO: naughty! not tested
  def follow
    load_user
    follower = current_user
    follower.start_following(@user)
    redirect_to user_url(@user), :notice => "You are now following #{@user.full_name}"
  end

  private
  def load_user
    @user = User.find_active_by_username(params[:id])
  rescue UserNotFound
    render_404
  end
end
