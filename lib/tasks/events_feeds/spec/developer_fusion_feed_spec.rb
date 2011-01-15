require 'spec_helper'

describe DeveloperFusionFeed do
  before :each do
    RSS::Parser.stub!(:parse).
            and_return(mock_feed)
    RSS::Parser.stub!(:parse).
            with(URI.parse("http://www.developerfusion.com/community/events/north-america/us/format/atom/")).
            and_return(mock_feed)
    @events = DeveloperFusionFeed.new.get_events
  end

  it "should creates events for each item in the feeds" do
    @events.size.should == 4
  end

  it "should parse country from title" do
    @events.first.country.should == "United Kingdom"
  end

  it "should parse city from title" do
    @events.first.city.should == "Birmingham"
  end

  it "should get the link from the item" do
    @events.first.link.should == mock_feed.items.first.link.href
  end

  it "should get the date from the title" do
    @events.first.date.day.should == 27
    @events.first.date.month.should == 7
    @events.first.date.year.should == 2010
  end

  it "should get the actual title from the item title" do
    @events[0].title.should == "Summer Security"
    @events[1].title.should == "techmesh: Hull - A collaboration networking event with Mark Conway, Director of Business Services at KC"
  end

  it "should get description from item description" do
    @events.first.description.should == mock_feed.items.first.summary.content
  end

  it "should generate a unique identifier from the developer fusion event" do
    @events.first.unique_identifier.should ==
            "developer-fusion-76810"
  end

  private
  def mock_feed
    mock_feed = mock(:feed).as_null_object
    mock_feed.stub(:items).and_return(mock_items)
    @mock_feed ||= mock_feed
  end

  def mock_items
    item_1 = {
            :title => "Summer Security - 27 Jul 2010 in (Birmingham, United Kingdom)",
            :summary => "The sun is out (we hope) and summer is here, but so are the hackers and so we still need to be aware of the bad guys out there.  It's not just a case now of hiding behind SSL either as our speaker tonight will show.  It's a scary Internet and just when you thought it was safe to browse",
            :link => "http://www.developerfusion.com/event/76810/summer-security/"
    }

    item_2 = {
            :title => "techmesh: Hull - A collaboration networking event with Mark Conway, Director of Business Services at KC - 28 Jul 2010 in (Hull, United Kingdom)",
            :summary => "Attend techmesh: Hull and expand your business connections.  The event is about encouraging collaboration, making new contacts and listening to inspiring key note speakers.",
            :link => "http://www.developerfusion.com/event/84607/techmesh-hull-a-collaboration-networking-event-with-mark-conway-director-of-business-services-at-kc/"
    }

    mock_items = [item_1, item_2].map do |item|
      mock_item = mock(:item)
      mock_title = mock(:title)
      mock_title.stub!(:content => item[:title])
      mock_item.stub!(:title => mock_title)
      mock_item.stub!(:to_ary => nil)
      mock_summary = mock(:summary)
      mock_summary.stub!(:content => item[:summary])
      mock_item.stub!(:summary => mock_summary)
      mock_link = mock(:link)
      mock_link.stub!(:href => item[:link])
      mock_item.stub(:link => mock_link)
      mock_item
    end

    @mock_items ||= mock_items
  end
end