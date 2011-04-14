require 'spec_helper'

describe Link do
  it "should have a mandatory title" do
    link = Link.new(:title => '')

    link.valid?

    link.errors[:title].any?.should be_true
  end

  it "should have a url" do
    link = Link.new(:url => '')

    link.valid?

    link.errors[:url].any?.should be_true
  end

  it "should have a well formatted url" do
    link_with_wrong_url = Link.new(:url => 'whatever I''m not really a url')
    link_with_valid_url = Link.new(:url => 'http://www.superdevs.com/events')

    link_with_wrong_url.valid?
    link_with_valid_url.valid?

    link_with_wrong_url.errors[:url].any?.should be_true
    link_with_valid_url.errors[:url].should be_empty
  end

  it "should have a description" do
    link = Link.new(:description => '')

    link.valid?

    link.errors[:description].any?.should be_true
  end
end
