class MembershipsController < ApplicationController
  before_filter :require_user
  before_filter :load_group

  def create
    load_group
    Membership.create(:user => current_user, :group => @group)
    redirect_to_group_with_notice('You are now a member of this group.')
  end

  def destroy
     if user_is_allowed_to_delete_membership
      Membership.delete(params[:id])
      redirect_to_group_with_notice('You are not a member of this group anymore.')
    else
      render_unauthorised_access
    end
  end

  private 
  def load_group
    @group = Group.find_active_by_unique_name(params[:group_id])
  rescue GroupNotFound
    render_404
  end

  def redirect_to_group_with_notice(notice)
    redirect_to group_url(@group.unique_name), :notice => notice
  end

  def user_is_allowed_to_delete_membership
    membership = Membership.find(params[:id])
    membership.user.id == current_user.id
  end

  def return_path
    group_url(load_group)
  end
end
