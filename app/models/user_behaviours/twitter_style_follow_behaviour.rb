module UserBehaviours
  module TwitterStyleFollowBehaviour
    def deliver_new_follower_notification!(follower)
      Notifier.deliver_new_follower_notification(self, follower)
    end

    def start_following(user)
      Relationship.create(:follower_id => self.id, :followed_id => user.id)
      user.deliver_new_follower_notification!(self)
    end

    def followers
      followers = Relationship.where("followed_id = ?", self.id).map { |r| r.follower_id }
      User.all_active_users.find_all { |u| followers.include?(u.id) }
    end

    def following
      followed = Relationship.where("follower_id = ?", self.id).map { |r| r.followed_id }
      User.all_active_users.find_all { |u| followed.include?(u.id) }
    end

    def following?(user)
      self.following.include?(user) or user == self
    end
  end
end
