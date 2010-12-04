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

  def has_no_city?
    @user.city.to_s.empty?
  end

  def hide_city_class
    has_no_city? ? 'hidden' : ''
  end

  def has_no_website?
    @user.website.to_s.empty?
  end

  def hide_website_class
    has_no_website? ? 'hidden' : ''
  end

  def has_no_phone?
    @user.phone_number.to_s.empty?
  end

  def hide_phone_class
    has_no_phone? ? 'hidden' : ''
  end
end