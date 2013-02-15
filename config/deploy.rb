require "bundler/capistrano"

set :application, "businesshound"
set :repository,  "git@github.com:gauravmc/businesshound.git"
set :deploy_to, "/home/gaurav/businesshound"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "root"

set :ssh_options, { :forward_agent => true }

server "192.81.222.241", :app, :web, :db, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:update_code", "deploy:migrate"
after "deploy:restart", "deploy:cleanup"


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end