begin
  require 'delayed/tasks'
rescue LoadError
  STDERR.puts "Run `bundle:install` to install delayed_job"
end
