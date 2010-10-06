class MembersController < ApplicationController
  before_filter :require_user
  before_filter :load_group

  def create
    load_group
    Member.create(:user => current_user, :group => @group)
    redirect_to_group_with_notice('You are now a member of this group.')
  end

  private 
  def load_group
    @group = Group.find_active_by_unique_name(params[:id])
  rescue GroupNotFound
    render_404
  end

  def redirect_to_group_with_notice(notice)
    redirect_to(@group, :notice => notice)
  end
end
