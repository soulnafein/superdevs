class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:follow, :edit_mandatory_details, :edit_accounts, :complete_registration, :update]

  def index
    @users = User.all_active_users_per_page params[:page]
  end

  def show
    load_user
  end

  def edit_accounts
    load_user
    render :layout => false if @user
  end

  def edit_mandatory_details
  end

  def complete_registration
    original_username = current_user.username
    current_user.email = params[:user][:email]
    current_user.username = params[:user][:username]
    current_user.full_name = params[:user][:full_name]
    current_user.agreed_tc_and_pp = params[:user][:agreed_tc_and_pp]
    current_user.password = "v3ryc0mpl3xpa$$w0rd27037289373289326hajsdhds"
    current_user.password_confirmation = "v3ryc0mpl3xpa$$w0rd27037289373289326hajsdhds"
    current_user.save!
    puts "WHat the fuck?"
    redirect_to user_url(current_user.username), :notice => 'Registration complete.'
  rescue ActiveRecord::RecordInvalid
    current_user.username = original_username
    render :action => :edit_mandatory_details
  end

  def update
    load_user
    @user.update_attributes!(params[:user])
    respond_to do |format|
      format.html { redirect_to user_url(@user.username), :notice => 'Profile successfully updated.' }
      format.json { head 200 }
    end
  rescue ActiveRecord::RecordInvalid
    head 400
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
    @user.username = params[:user][:username]
    @user
    if @user.save
      flash[:notice] = "Successfully added RPX authentication for this account."
      render :action => 'show'
    else
      render :action => 'edit_mandatory_details'
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
