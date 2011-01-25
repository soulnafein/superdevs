require File.dirname(__FILE__) + '/developer_fusion_feed'
require File.dirname(__FILE__) + '/meetup_feed'
module EventsFeedsImportJob
  def self.execute
    configuration_meetups = {
            841735  => ["Londonjavacommunity", "London", "United Kingdom", 6],
            1501605 => ['grad-dc', "London", "United Kingdom", 7],
            1278286 => ["UK-London-C-CPlusPlus-Techies-Meetup-Group", "London", "United Kingdom", nil],
            543596  => ["dotnet-121", "London", "United Kingdom", 3],
            1594214 => ["FSharpLondon", "London", "United Kingdom", nil],
            1562942 => ["London-scala", "London", "United Kingdom", nil],
            820982  => ["android", "London", "United Kingdom", nil],
            218194  => ["phplondon", "London", "United Kingdom", nil],
            919892  => ["javascript-3", "London", "United Kingdom", nil],
            1350857 => ["skillsmatter", "London", "United Kingdom", nil],
            1387254 => ["Ruby-Business-Uk", "London", "United Kingdom", nil],
            1485504 => ["DDD-London", "London", "United Kingdom", nil],
            1517445 => ["agiletesting", "London", "United Kingdom", nil]
    }

    developer_fusion_events = DeveloperFusionFeed.new.get_events
    puts "Developers fusion events: #{developer_fusion_events.count}"
    meetup_events = MeetupFeed.new(configuration_meetups).get_events
    puts "Meetup.com events: #{meetup_events.count}"
    events = developer_fusion_events + meetup_events
    events.flatten.compact.each do |e|
      existing_event = Event.where(:unique_identifier => e.unique_identifier).first
      begin
        if existing_event
          existing_event.update_attributes(e.attributes)
          existing_event.group_id = e.group_id
          existing_event.save
        else
          e.save
        end
      rescue Exception => ex
        puts ex.display
      end
    end
  end
end
