class Relationship < ActiveRecord::Base
  belongs_to :follower, :class_name => User.to_s
  belongs_to :followed, :class_name => User.to_s

  def self.followers_of_user(user)
    Relationship.where("followed_id = ?", user.id).map { |r| r.follower }
  end

  def self.users_followed_by(user)
    Relationship.where("follower_id = ?", user.id).map { |r| r.followed }
  end

  def self.subset_of_users_followed_by(user, users)
    Relationship.where("follower_id = ? and followed_id in (?)", user, users.map {|u| u.id})
  end
end
