require File.dirname(__FILE__) + '/events_feeds/lib/events_feeds_import_job'
require File.dirname(__FILE__) + '/email_notifications/lib/tomorrow_event_notification'
require File.dirname(__FILE__) + '/email_notifications/lib/weekly_event_notification'
desc "Task called by Heroku cron: Import events like conferences, talks, geek nights from different web sources"
task :cron => :environment do
  EventsFeedsImportJob.execute
  WeeklyEventNotification.execute
  TomorrowEventNotification.execute
end
