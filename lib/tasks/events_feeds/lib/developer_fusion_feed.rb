require 'rss'
require 'uri'

class DeveloperFusionFeed
  def get_events
    feed = load_feed("http://www.developerfusion.com/community/events/europe/gb/format/atom/")
    
    feed.items.map do |item|
      title, date, city, country = parse_title_date_city_country_from_title(item.title.content)
      Event.new(:title => title, :country => country, :city => city,
                :link => item.link.href, :date => date, :description => item.summary.content)
    end
  end

  private
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