class GroupsController < ApplicationController
  def show
    load_group
  end

  def index
    @groups = Group.all_active
  end

  before_filter :require_user, :only => [:edit, :update]

  def edit
    load_group
    render_unauthorised_access unless current_user_is_the_organizer
  end

  def update
    load_group
    if current_user_is_the_organizer
      @group.update_attributes!(params[:group])
      redirect_to(@group, :notice => 'Description updated.')
    else
      render_unauthorised_access
    end
  end

  def current_user_is_the_organizer
    @group.organizer?(current_user)
  end

  private
  def load_group
    @group = Group.find_active_by_unique_name(params[:id])
  rescue GroupNotFound
    render_404
  end
end