class Link < ActiveRecord::Base
  belongs_to :author, :class_name => User.to_s

  validates_presence_of :title, :url, :description
  validates :url, :valid_url => true

  def self.get_latest
    self.order('created_at DESC')
  end
end
