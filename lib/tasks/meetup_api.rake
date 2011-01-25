require File.dirname(__FILE__) + '/meetup_api/meetup_api'
namespace :meetup do
  desc "retrieve group id given a list of groups name"
  task :retrieve_groups_id do
    configuration_file = File.expand_path(File.dirname(__FILE__) + "/../../meetup_groups_names")
    groups_name = File.read(configuration_file).split(",")
    ids = MeetupApi.retrieve_groups_id(groups_name)
    puts ids.join(",")
  end
end