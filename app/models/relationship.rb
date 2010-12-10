class Relationship < ActiveRecord::Base
  belongs_to :follower, :class_name => User.to_s
  belongs_to :followed, :class_name => User.to_s

  def self.followers_of_user(user)
    followers = Relationship.where("followed_id = ?", user.id).map { |r| r.follower_id }
    User.all_active_users.find_all { |u| followers.include?(u.id) }
  end

  def self.users_followed_by(user)
    followed = Relationship.where("follower_id = ?", user.id).map { |r| r.followed_id }
    User.all_active_users.find_all { |u| followed.include?(u.id) }
  end
end
