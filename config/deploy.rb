set :application, "superdevs"
set :user, "dsantoro"
default_run_options[:pty] = true

set :repository,  "git@github.com:soulnafein/superdevs.git"
set :scm, :git
set :scm_username, "soulnafein@gmail.com"

role :web, "superdevs.com"                          # Your HTTP server, Apache/etc
role :app, "superdevs.com"                          # This may be the same as your `Web` server
role :db,  "superdevs.com", :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
