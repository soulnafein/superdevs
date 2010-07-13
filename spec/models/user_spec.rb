require 'spec_helper'

describe User do
  it "should have a profile picture" do
    user = User.new(:email => "soulnafein@gmail.com")
    user.profile_picture.should == Gravatar.for_email("soulnafein@gmail.com")
  end

  it "should have a small profile picture" do
    user = User.new(:email => "soulnafein@gmail.com")
    user.small_profile_picture.should == Gravatar.for_email("soulnafein@gmail.com", 32)
  end
end
