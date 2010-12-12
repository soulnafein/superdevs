module EventBehaviours
  module AttendingAndTracking

    def has_attendee?(user)
      self.attendees.include?(user)
    end

    def register_attendee(user)
      self.attendees << user unless has_attendee?(user)
    end

    def unregister_attendee(user)
      self.attendees.delete(user)
    end

    def has_tracker?(user)
      self.trackers.include?(user)
    end

    def register_tracker(user)
      self.trackers << user unless has_tracker?(user)
    end

    def unregister_tracker(user)
      self.trackers.delete(user)
    end

    def attendees_followed_by(user)
      Relationship.subset_of_users_followed_by(user, self.attendees).map {|r| r.followed }
    end
  end
end