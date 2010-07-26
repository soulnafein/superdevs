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

before "deploy:bundle_install", "deploy:install_bundler"
after "deploy:update_code", "deploy:bundle_install"

namespace :deploy do
  desc "installs Bundler if it is not already installed"
  task :install_bundler, :roles => :app do
    sudo "sh -c 'if [ -z `which bundle` ]; then echo Installing Bundler; gem install bundler; fi'"
  end

  desc "run 'bundle install' to install Bundler's packaged gems for the current deploy"
  task :bundle_install, :roles => :app do
    run "cd #{release_path} && bundle install"
  end
end

