class Link < ActiveRecord::Base
  belongs_to :author, :class_name => User.to_s
  def self.get_latest
    self.order('created_at DESC')
  end
end
