class MeetupFeed
  API_KEY = "8043755844411bd5a772c72373c3357"
  FEED_URI_TEMPLATE = "http://api.meetup.com/events.atom/?&key=#{API_KEY}&group_id="

  def initialize(configuration)
    @configuration = configuration
    @group_ids = configuration.keys
  end

  def get_events
    get_events_by_group_ids(@group_ids)
  end

  private
  def get_events_by_group_ids(group_ids)
    feed = load_feed(generate_feed_url(group_ids))
    feed.items.map do |item|
      Event.new(:title => item.title.content.strip,
                :date => parse_date_from_item(item),
                :link => item.link.href,
                :country => @configuration[group_ids.first][2],
                :city => @configuration[group_ids.first][1])
    end
  end

  def generate_feed_url(group_ids)
    FEED_URI_TEMPLATE + group_ids.join(",")
  end

  def parse_date_from_item(item)
    #[CDATA[<h3>Sat Jul 31 12:00:00 BST 2010</h3>
    date_regexp = Regexp.new(/<h3>(\w+ \w+ \w+ \d+:\d+:\d+ \w+ \d\d\d\d)<\/h3>/i)
    matches = date_regexp.match(item.content.content)
    raise "Couldn't match date in content:\n #{item.content.content}" if (not matches) || (not matches[1])
    return matches[1]
  end

  #TODO: duplicated, refactor! check developer_fusion_feed class
  def load_feed(url)
    rss_source = URI.parse(url)
    rss = nil
    begin
      rss = RSS::Parser.parse(rss_source)
    rescue RSS::InvalidRSSError
      rss = RSS::Parser.parse(rss_source, false)
    end
    rss
  end
end