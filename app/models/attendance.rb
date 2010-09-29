class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
end

# == Schema Information
#
# Table name: attendances
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

