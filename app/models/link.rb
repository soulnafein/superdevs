class Link < ActiveRecord::Base
  def self.get_latest
    self.order('created_at DESC')
  end
end
