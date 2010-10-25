# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(Rails)
require 'rspec/rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

#fixture to be substituted by factory girl
module TestBuilders
  def user_david
    user = User.new(:full_name => "David", :username => "davidsantoro")
    user.id = 123
    user
  end

  def user_ken
    user = User.new(:full_name => "Ken", :username => "kenfassone")
    user.id = 678
    user
  end

  def group
    Group.new do |g|
      g.name = "London Developers"
      g.unique_name = "london-developers"
      g.organizer = user_david
      g.description = "A description"
      g.active = true
    end
  end
end

module SessionTestHelper
  def logged_in_user_is(user)
    session = mock(UserSession).as_null_object
    session.stub(:record).and_return(user)
    UserSession.stub(:find).and_return(session)
    user
  end
end

Rspec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, comment the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
end


