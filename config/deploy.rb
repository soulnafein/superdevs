set :application, "superdevs"
set :repository,  "git@github.com:soulnafein/superdevs.git"
set :user, "dsantoro"
set :scm_username, "soulnafein@gmail.com"
default_run_options[:pty] = true

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "superdevs.com"                          # Your HTTP server, Apache/etc
role :app, "superdevs.com"                          # This may be the same as your `Web` server
role :db,  "superdevs.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
