require File.dirname(__FILE__) + '/events_feeds/lib/events_feeds_import_job'
desc "Task called by Heroku cron: Import events like conferences, talks, geek nights from different web sources"
task :cron => :environment do
  EventsFeedsImportJob.execute
end
