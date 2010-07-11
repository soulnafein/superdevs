class Person < ActiveRecord::Base
  acts_as_authentic
  
  def profile_picture
    Gravatar.for_email(self.email)
  end

  def small_profile_picture
    Gravatar.for_email(self.email, 32)
  end
end
