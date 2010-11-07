class UserSession < Authlogic::Session::Base
  find_by_login_method :find_by_username_or_email
  generalize_credentials_error_messages "Your login information is invalid"
  rpx_key "c8941495e4daafacfa00ee54cb7e1cd4d43c1965"
  rpx_extended_info

  private
  def map_rpx_data
    puts @rpx_data['profile']
    self.attempted_record.activate!
    self.attempted_record.full_name = @rpx_data['profile']['displayName'] if attempted_record.full_name.blank?
    self.attempted_record.username = @rpx_data['profile']['preferredUsername'].gsub(".", "") if attempted_record.username.blank?
    self.attempted_record.email = @rpx_data['profile']['email'] if attempted_record.email.blank?
  end

  def map_rxp_data_each_login
  end
end