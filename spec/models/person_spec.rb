require 'spec_helper'

describe Person do
  it "should have a profile picture" do
    person = Person.new(:email => "soulnafein@gmail.com")
    person.profile_picture.should == Gravatar.for_email("soulnafein@gmail.com")
  end

  it "should have a small profile picture" do
    person = Person.new(:email => "soulnafein@gmail.com")
    person.small_profile_picture.should == Gravatar.for_email("soulnafein@gmail.com", 32)
  end
end
