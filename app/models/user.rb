class User < ActiveRecord::Base
  acts_as_authentic

  attr_accessible :full_name,
                  :tagline,
                  :bio,
                  :location,
                  :company,
                  :job_title,
                  :website,
                  :twitter_username,
                  :linkedin_profile,
                  :github_account,
                  :interests,
                  :phone_number,
                  :blog_feed,
                  :email,
                  :username,
                  :password,
                  :password_confirmation

  attr_readonly :username, :email, :password, :password_confirmation

  validates_presence_of :full_name
  validate :must_accept_terms_and_conditions_and_privacy_policy

  def must_accept_terms_and_conditions_and_privacy_policy
    if not self.agreed_tc_and_pp
      errors.add_to_base("You must agree to our Terms and Conditions and Privacy Policy")
    end
  end

  def profile_picture
    Gravatar.for_email(self.email)
  end

  def small_profile_picture
    Gravatar.for_email(self.email, 32)
  end

  def medium_profile_picture
    Gravatar.for_email(self.email, 50)
  end

  def self.find_active(id)
    user = User.where(:id => id).first || (raise UserNotFound)
    raise UserNotFound unless user.active?
    user
  end

  def self.all_active_users
    User.where("active <> 0")
  end

  def self.find_by_username_or_email(username_or_email)
    User.where(:email => username_or_email).first ||
    User.where(:username => username_or_email).first
  end

  def activate!
    self.active = true
    save
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  def deliver_welcome!
    reset_perishable_token!
    Notifier.deliver_welcome(self)
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
end

class UserNotFound < Exception
end
