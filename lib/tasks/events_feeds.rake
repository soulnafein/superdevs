require File.dirname(__FILE__) + '/events_feeds/lib/events_feeds_import_job'
namespace :jobs do
  desc "Import events like conferences, talks, geek nights from different web sources"
  task :import_events_feeds => :environment do
    EventsFeedsImportJob.execute
  end
end