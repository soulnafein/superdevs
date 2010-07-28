require 'rss'
require 'uri'

class DeveloperFusionFeed
  FEEDS = [
            "http://www.developerfusion.com/community/events/europe/gb/format/atom/",
            "http://www.developerfusion.com/community/events/north-america/us/format/atom/"
          ]
  def get_events
    feeds_items = get_combined_feeds_items
    return create_events_from_feeds_items(feeds_items)
  end

  private
  def get_combined_feeds_items
    FEEDS.each.map { |feed_url| load_feed(feed_url).items }.flatten
  end

  def create_events_from_feeds_items(feeds_items)
    feeds_items.map do |item|
      title, date, city, country = parse_title_date_city_country_from_title(item.title.content)
      Event.new(:title => title, :country => country, :city => city,
                :link => item.link.href, :date => date, :description => item.summary.content)
    end
  end

  def parse_title_date_city_country_from_title(title)
    title_date_city_country = Regexp.new(/^(.*) - ([^\s]+ [^\s]+ [^\s]+) in \(([^,]+), ([^)]+)\)$/)
    matches = title_date_city_country.match(title)
    matches.to_a[1..-1]
  end

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