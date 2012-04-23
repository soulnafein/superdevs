require 'digest/md5'

class Gravatar
  def self.for_email(email, size=160)
    Gravatar.new(email,size)
  end
  
  def to_html
    "<img src=\"http://www.gravatar.com/avatar/#{@hash}?s=#{@size}&d=identicon\" alt=\"Profile picture\" />"
  end

  def initialize(email,size)
    @hash = Digest::MD5.hexdigest(email.to_s.downcase)
    @size = size
  end

  def ==(other)
    return false unless other.class == Gravatar 
    @hash == other.hash
  end

  attr_reader :hash
end
