class Person < ActiveRecord::Base
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
  
  def profile_picture
    Gravatar.for_email(self.email)
  end

  def small_profile_picture
    Gravatar.for_email(self.email, 32)
  end
end
