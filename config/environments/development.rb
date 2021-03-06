Superdevs::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.active_support.deprecation = :log
  config.action_mailer.delivery_method = :smtp 
  config.action_mailer.smtp_settings = { 
    :address => "smtp.gmail.com", 
    :port => 587, 
    :domain => 'superdevs.com', 
    :user_name => 'admin@superdevs.com', 
    :password => 'm4rt1nf0wl3r', 
    :authentication => 'plain', 
    :enable_starttls_auto => true } 
  #config.action_mailer.delivery_method = :sendmail 
  # Defaults to: 
  # config.action_mailer.sendmail_settings = { 
  # :location => '/usr/sbin/sendmail', 
  # :arguments => '-i -t' 
  # } 

  config.action_mailer.perform_deliveries = false
  config.action_mailer.raise_delivery_errors = true 
end
