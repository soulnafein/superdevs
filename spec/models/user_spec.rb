require 'spec_helper'

describe User do
  it "should have a profile picture" do
    user = User.new(:email => "soulnafein@gmail.com")
    user.profile_picture.should == Gravatar.for_email("soulnafein@gmail.com")
  end

  it "should have a medium profile picture" do
    user = User.new(:email => "soulnafein@gmail.com")
    user.medium_profile_picture.should == Gravatar.for_email("soulnafein@gmail.com", 100)
  end

  it "should have a small profile picture" do
    user = User.new(:email => "soulnafein@gmail.com")
    user.small_profile_picture.should == Gravatar.for_email("soulnafein@gmail.com", 32)
  end

  context "When validating a blog_feed url" do
    it "should not accept urls without scheme (e.g. http)" do
      user = User.new(:website => "www.google.com")

      user.valid?

      user.errors[:website].first.should == "is not a valid URL. Remember to add http:// or other schema in front"
    end

    it "should accept an empty url" do
      user = User.new(:website => '')

      user.valid?

      user.errors[:website].should be_empty
    end

    it "should accept a nil url" do
      user = User.new(:website => nil)

      user.valid?

      user.errors[:website].should be_empty
    end
  end

  context "When validating a linkedin profile url" do
    it "should not accept urls without scheme (e.g. http)" do
      user = User.new(:linkedin_profile => "www.google.com")

      user.valid?

      user.errors[:linkedin_profile].first.should == "is not a valid URL. Remember to add http:// or other schema in front"
    end

    it "should accept an empty url" do
      user = User.new(:linkedin_profile=> '')

      user.valid?

      user.errors[:linkedin_profile].should be_empty
    end

    it "should accept a nil url" do
      user = User.new(:linkedin_profile=> nil)

      user.valid?

      user.errors[:linkedin_profile].should be_empty
    end
  end

  context "When validating a blog feed url" do
    it "should not accept urls without scheme (e.g. http)" do
      user = User.new(:blog_feed => "www.google.com")

      user.valid?

      user.errors[:blog_feed].first.should == "is not a valid URL. Remember to add http:// or other schema in front"
    end

    it "should accept an empty url" do
      user = User.new(:blog_feed => '')

      user.valid?

      user.errors[:blog_feed].should be_empty
    end

    it "should accept a nil url" do
      user = User.new(:blog_feed => nil)

      user.valid?

      user.errors[:blog_feed].should be_empty
    end
  end
end
