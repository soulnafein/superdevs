class GroupsController < ApplicationController
  def show
    load_group
  end

  def edit
    load_group
  end

  def index
    @groups = Group.all_active
  end

  def update
    load_group
    @group.update_attributes!(params[:group])
    redirect_to(@group, :notice => 'Description updated.')
  end

  private
  def load_group
    @group = Group.find_active_by_unique_name(params[:id])
  rescue GroupNotFound
    render_404
  end
end