require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Superdevs
  class Application < Rails::Application
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
    config.action_mailer.default_url_options = {:host => "superdevs.com"}
    config.action_mailer.delivery_method = :sendmail
    config.action_mailer.sendmail_settings = {
            :location => '/usr/sbin/sendmail'
    }
  end
end
