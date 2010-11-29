module UsersHelper
  def user_can_edit
    @user == current_user
  end
end