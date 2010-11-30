module UsersHelper
  def user_can_edit
    @user == current_user
  end

  def has_no_tagline?
    @user.tagline.to_s.empty?
  end

  def hide_tagline_class
    has_no_tagline? ? 'hidden' : ''
  end

  def has_no_company?
    @user.company.to_s.empty?
  end

  def hide_company_class
    has_no_company? ? 'hidden' : ''
  end
end