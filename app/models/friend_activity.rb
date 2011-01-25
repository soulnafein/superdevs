class FriendActivity < ActiveRecord::Base
  belongs_to :friend, :class_name => User.to_s
  belongs_to :event

  def self.latest_friends_activities_for_user(user)
    FriendActivity.joins('JOIN relationships ON friend_id = followed_id').
            where(:follower_id => user.id).
            order("date desc").limit(50)
  end
end
