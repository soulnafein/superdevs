#encoding: utf-8
require 'spec_helper'

describe MeetupFeed do
  before :each do
    @configuration = { 1501605 => ["London Java Community", "London", "United Kingdom", 456]}
    feed_uri = URI.parse("http://api.meetup.com/events.json/?&key=8043755844411bd5a772c72373c3357&group_id=1501605")
    Net::HTTP.stub(:get).with(feed_uri).and_return(mock_feed)
    @events = MeetupFeed.new(@configuration).get_events
  end

  it "should creates events for each item in the feeds" do
    @events.size.should == 1
  end

  it "should get the title from the item" do
    @events.first.title.should == "Online Monthly Prize Draw: Packt Publishing"
  end

  it "should parse date from item" do
    @events.first.date.day.should == 31
    @events.first.date.month.should == 1
    @events.first.date.year.should == 2011
  end

  it "should generate a unique identifier from the meetup identifier" do
    @events.first.unique_identifier.should == "http://www.meetup.com/grad-dc/calendar/16021592/"
  end

  it "should parse description from item" do
    expected_description = "Please note this is an online monthly prize draw and no actual meeting will take place.[Packt Publishing ][1] are a unique publishing company specializing in highly focused books on specific technologies and solutions - please visit their site to find out more about them: [www.packtpub.com][2]  Each month we run a promotion with Packt in which GDC members will be selected at random to receive free books. This month we are offering 2 GDC members the chance to win; First Prize Winner will receive 1 print copy of his/her choice, Runner Up Winner - 1 ecopy of his/her choice There are a list of 6 books below. To take part in the promotion all you have to do is RSVP to this event on Meetup and complete the questions. Here are the books on offer this month, the winner will be picked at random and announced at the end of the month:[Mastering phpMyAdmin 3.3.x for Effective MySQL Management][3] [Microsoft Dynamics NAV Administration][4] [Moodle 1.9 Testing and Assessment][5] [Microsoft Dynamics NAV 2009 Programming Cookbook ][6] [Moodle as a Curriculum and Information Management System][7] [Moodle 1.9 Top Extensions Cookbook][8] To take part in the promotion all you have to do is RSVP to this event on Meetup and complete the questions. Please visit the Packt site at [www.packtpub.com][9] Good luck, Barry Cranford\n\n\n  [1]: http://www.packtpub.com/\n  [2]: http://www.packtpub.com/\n  [3]: https://www.packtpub.com/mastering-phpmyadmin-3-3-x-for-effective-mysql-management/book\n  [4]: https://www.packtpub.com/microsoft-dynamics-nav-administration/book\n  [5]: https://www.packtpub.com/moodle-1-9-testing-and-assessment/book\n  [6]: https://www.packtpub.com/microsoft-dynamics-nav-2009-programming-cookbook/book\n  [7]: https://www.packtpub.com/moodle-as-a-curriculum-and-information-management-system/book\n  [8]: https://www.packtpub.com/moodle-1-9-top-extensions-cookbook/book\n  [9]: http://www.packtpub.com/\n"
    @events.first.description.should == expected_description
  end

  it "should get link url from item href" do
    @events.first.link.should == "http://www.meetup.com/grad-dc/calendar/16021592/"
  end

  it "should get country and city from configuration" do
    @events.first.country.should == "United Kingdom"
    @events.first.city.should == "London"
  end

  it "should associate the relative superdevs group" do
    @events.first.group_id.should == 456
  end

  private
  def mock_feed
    "{\"results\":[{\"rsvpcount\":\"8\",\"venue_name\":\"Packt Publishing Promotion\",\"payment_required\":\"0\",\"maybe_rsvpcount\":\"0\",\"allow_maybe_rsvp\":\"0\",\"rsvpable\":\"OPEN\",\"member_status\":\"nonmember\",\"time\":\"Mon Jan 31 12:00:00 GMT 2011\",\"venue_zip\":\"\",\"venue_visibility\":\"public\",\"feedesc\":\"\",\"updated\":\"Wed Jan 12 10:38:39 EST 2011\",\"venue_address1\":\"This is an online promotion\",\"description\":\"Please note this is an online monthly prize draw and no actual meeting will take place.<br \\/><br \\/><a href=\\\"http:\\/\\/www.packtpub.com\\/\\\" target=\\\"_blank\\\">Packt Publishing <\\/a>are a unique publishing company specializing in highly focused books on specific technologies and solutions - please visit their site to find out more about them: <a href=\\\"http:\\/\\/www.packtpub.com\\/\\\" target=\\\"_blank\\\">www.packtpub.com<\\/a> <br \\/><br \\/>Each month we run a promotion with Packt in which GDC members will be selected at random to receive free books. This month we are offering 2 GDC members the chance to win; <br \\/><br \\/>First Prize Winner will receive 1 print copy of his\\/her choice, <br \\/>Runner Up Winner - 1 ecopy of his\\/her choice <br \\/><br \\/>There are a list of 6 books below. To take part in the promotion all you have to do is RSVP to this event on Meetup and complete the questions. <br \\/>Here are the books on offer this month, the winner will be picked at random and announced at the end of the month:<br \\/><br \\/><a href=\\\"https:\\/\\/www.packtpub.com\\/mastering-phpmyadmin-3-3-x-for-effective-mysql-management\\/book\\\" target=\\\"_blank\\\">Mastering phpMyAdmin 3.3.x for Effective MySQL Management<\\/a><br \\/><a href=\\\"https:\\/\\/www.packtpub.com\\/microsoft-dynamics-nav-administration\\/book\\\" target=\\\"_blank\\\">Microsoft Dynamics NAV Administration<\\/a><br \\/><a href=\\\"https:\\/\\/www.packtpub.com\\/moodle-1-9-testing-and-assessment\\/book\\\" target=\\\"_blank\\\">Moodle 1.9 Testing and Assessment<\\/a><br \\/><a href=\\\"https:\\/\\/www.packtpub.com\\/microsoft-dynamics-nav-2009-programming-cookbook\\/book\\\" target=\\\"_blank\\\">Microsoft Dynamics NAV 2009 Programming Cookbook <\\/a><br \\/><a href=\\\"https:\\/\\/www.packtpub.com\\/moodle-as-a-curriculum-and-information-management-system\\/book\\\" target=\\\"_blank\\\">Moodle as a Curriculum and Information Management System<\\/a><br \\/><a href=\\\"https:\\/\\/www.packtpub.com\\/moodle-1-9-top-extensions-cookbook\\/book\\\" target=\\\"_blank\\\">Moodle 1.9 Top Extensions Cookbook<\\/a><br \\/><br \\/>To take part in the promotion all you have to do is RSVP to this event on Meetup and complete the questions. <br \\/><br \\/>Please visit the Packt site at <a href=\\\"http:\\/\\/www.packtpub.com\\/\\\" target=\\\"_blank\\\">www.packtpub.com<\\/a><br \\/><br \\/>Good luck, <br \\/><br \\/>Barry Cranford<br \\/>\",\"venue_address2\":\"\",\"venue_address3\":\"\",\"venue_id\":\"1212407\",\"rsvp_closed\":\"0\",\"photo_count\":\"\",\"lon\":\"-0.10000000149011612\",\"no_rsvpcount\":\"3\",\"status\":\"upcoming\",\"photo_url\":\"http:\\/\\/photos1.meetupstatic.com\\/photos\\/event\\/3\\/3\\/9\\/global_14868825.jpeg\",\"group_id\":\"1501605\",\"utc_rsvp_cutoff\":\"None\",\"questions\":[\"Please enter the name of the book(s) that you would like to receive\",\"Are there any new Job opportunities that would interest you at present?\",\"If you answered yes please give details so we can send suitable matches e.g. (perm\\/contract, location, rate\\/salary, tech) If you'd prefer just write \\\"call\\\" and we'll get in touch to discuss\",\"Please enter your full name\",\"Please enter your email address\"],\"rsvp_cutoff\":\"None\",\"attendee_count\":\"0\",\"fee\":\"0.0\",\"venue_map\":\"http:\\/\\/maps.google.com\\/staticmap?center=0.000000,0.000000&zoom=14&size=512x512&maptype=mobile&markers=0.000000,0.000000,blues&key=ABQIAAAAiB79SpLrOxrYbOzqaYGrvhQrNhSbWhQbZXKDt0w9V4y2n6CzahTrHTbQjuSGhL4xdTPFH0lRNNe4-A&sensor=false\",\"how_to_find_us\":\"\",\"venue_lat\":\"0.000000\",\"rsvp_open_time\":\"None\",\"my_waitlist_status\":\"\",\"organizer_id\":\"5719145\",\"myrsvp\":\"none\",\"id\":\"16021592\",\"ismeetup\":\"1\",\"venue_city\":\"There will be no physical meetup\",\"name\":\"Online Monthly Prize Draw: Packt Publishing \",\"photo_album_id\":\"\",\"lat\":\"51.52000045776367\",\"venue_state\":\"\",\"group_name\":\"Graduate Developer Community\",\"rsvp_limit\":\"0\",\"group_photo_url\":\"http:\\/\\/photos1.meetupstatic.com\\/photos\\/event\\/f\\/c\\/5\\/global_11500037.jpeg\",\"guest_limit\":\"2\",\"utc_time\":\"1296475200000\",\"waiting_rsvpcount\":\"0\",\"organizer_name\":\"Barry Cranford\",\"feecurrency\":\"GBP\",\"utc_rsvp_open_time\":\"None\",\"event_hosts\":[{\"member_name\":\"Barry Cranford\",\"member_id\":5719145}],\"venue_phone\":\"\",\"venue_lon\":\"0.000000\",\"rating_count\":0,\"event_url\":\"http:\\/\\/www.meetup.com\\/grad-dc\\/calendar\\/16021592\\/\",\"rating\":0}],\"meta\":{\"lon\":\"\",\"count\":1,\"link\":\"http:\\/\\/api.meetup.com\\/events.json\\/\",\"next\":\"\",\"total_count\":1,\"url\":\"http:\\/\\/api.meetup.com\\/events.json\\/?group_id=1501605&key=8043755844411bd5a772c72373c3357&radius=25.0&order=time&offset=0&format=json&page=200&fields=\",\"id\":\"\",\"title\":\"Meetup Events\",\"updated\":\"Wed Jan 12 10:38:39 EST 2011\",\"description\":\"API method for accessing meetup events\",\"method\":\"Events\",\"lat\":\"\"}}\n"
  end
end
