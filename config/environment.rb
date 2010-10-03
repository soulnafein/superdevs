# Load the rails application
require File.expand_path('../application', __FILE__)

config.middleware.use Rack::ForceDomain, ENV["DOMAIN"]
# Initialize the rails application
Superdevs::Application.initialize!
