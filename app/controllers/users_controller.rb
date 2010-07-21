class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:edit, :update]

  def index
    @users = User.all_active_users  
  end

  def show
    load_user
  end

  def edit
    load_user
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

  private
  def load_user
    @user = User.find_active(params[:id])
  rescue UserNotFound
    render_404
  end
end
