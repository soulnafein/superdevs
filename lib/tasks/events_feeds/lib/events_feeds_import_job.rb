require File.dirname(__FILE__) + '/developer_fusion_feed'
require File.dirname(__FILE__) + '/meetup_feed'
module EventsFeedsImportJob
  def self.execute
    configuration_meetups = {
            841735  => ["Londonjavacommunity", "London", "United Kingdom"],
            1278286 => ["UK-London-C-CPlusPlus-Techies-Meetup-Group", "London", "United Kingdom"],
            543596  => ["dotnet-121", "London", "United Kingdom"],
            1594214 => ["FSharpLondon", "London", "United Kingdom"],
            1562942 => ["London-scala", "London", "United Kingdom"],
            820982  => ["android", "London", "United Kingdom"],
            218194  => ["phplondon", "London", "United Kingdom"],
            919892  => ["javascript-3", "London", "United Kingdom"],
            1350857 => ["skillsmatter", "London", "United Kingdom"],
            1387254 => ["Ruby-Business-Uk", "London", "United Kingdom"],
            1485504 => ["DDD-London", "London", "United Kingdom"],
            1517445 => ["agiletesting", "London", "United Kingdom"]
    }


    events = DeveloperFusionFeed.new.get_events
    events += MeetupFeed.new(configuration_meetups).get_events
    events.each { |e| e.save! unless Event.exists?(e) }
  end
end
