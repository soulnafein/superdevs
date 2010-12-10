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
      Relationship.followers_of_user(self)
    end

    def following
      Relationship.users_followed_by(self)
    end

    def following?(user)
      self.following.include?(user) or user == self
    end
  end
end
