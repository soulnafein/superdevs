require File.dirname(__FILE__) + "/reverse_markdown.rb"

class MeetupFeed
  API_KEY = "8043755844411bd5a772c72373c3357"
  FEED_URI_TEMPLATE = "http://api.meetup.com/events.json/?&key=#{API_KEY}&group_id="

  def initialize(configuration)
    @configuration = configuration
    @group_ids = configuration.keys
  end

  def get_events
    get_events_by_group_ids(@group_ids)
  end

  def get_events_by_group_ids(group_ids)
    meetup_events = load_feed(generate_feed_url(group_ids))
    meetup_events.map do |item|
      meetup_group_id = item["group_id"].to_i
      begin
        Event.new do |e|
          e.title = item["name"].strip
          e.date = Time.at(item["utc_time"][0..-4].to_i).utc
          e.description = parse_description_from_item(item)
          e.unique_identifier = parse_unique_identifier_from_item(item)
          e.link = item["event_url"]
          e.country = @configuration[meetup_group_id][2]
          e.city = @configuration[meetup_group_id][1]
          e.group_id = @configuration[meetup_group_id][3]
        end
      rescue Exception => e
        puts "Error parsing meetup event with url: #{item['event_url']}"
        puts e.display
      end
    end
  end

  def generate_feed_url(group_ids)
    FEED_URI_TEMPLATE + group_ids.join(",")
  end

  def parse_description_from_item(item)
    description = "<p>#{item["description"]}</p>"
    description.gsub!(/<br[ ]*\/>/, "\n")
    ReverseMarkdown.new.parse_string(Iconv.conv('utf-8', 'iso-8859-1', description))
  end

  def parse_unique_identifier_from_item(item)
    item["event_url"]
  end

  def load_feed(url)
    uri = URI.parse(url)
    response = Net::HTTP.get(uri).to_s
    ActiveSupport::JSON.decode(response)["results"]
  end
end
