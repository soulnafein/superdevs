class GroupsController < ApplicationController
  def show
    @group = Group.find_active_by_unique_name(params[:id])
  rescue GroupNotFound
    render_404
  end
end