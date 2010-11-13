class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => User.to_s
  belongs_to :event
end
