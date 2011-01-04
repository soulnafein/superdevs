class Admin < ActiveRecord::Base
  belongs_to :user

  def self.user_admin?(user)
    Admin.exists?(:user_id => user.id)
  end
end
