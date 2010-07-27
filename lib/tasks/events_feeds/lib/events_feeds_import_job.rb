require File.dirname(__FILE__) + '/developer_fusion_feed'
module EventsFeedsImportJob
  def self.execute
    events = DeveloperFusionFeed.new.get_events
    events.each { |e| e.save! unless Event.exists?(e) }
  end
end
