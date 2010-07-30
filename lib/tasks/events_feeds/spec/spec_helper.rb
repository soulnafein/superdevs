# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV['RAILS_ENV'] = ENV['RAILS_ENV'] || 'test'
require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")
require 'rspec/rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

#require everything in lib
#Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each {|f| require f}
require File.expand_path(File.dirname(__FILE__)+"/../lib/developer_fusion_feed")
require File.expand_path(File.dirname(__FILE__)+"/../lib/meetup_feed")

Rspec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
end
