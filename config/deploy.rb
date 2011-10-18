# configure bundler
require 'bundler/capistrano'
set :bundle_without,  [:development, :test]

# configure multiple stages
set :stages, %w(vagrant prototype production)
set :default_stage, "prototype"
require 'capistrano/ext/multistage'

set :application, "gaia"
set :scm, :git
set :repository, "git@github.com:thenathanjones/gaia.git"
set :deploy_to, "/var/www/gaia"

set :deploy_via, :copy
set :copy_cache, true
set :copy_exclude, [".git"]

set :user, "app"
set :use_sudo, false
ssh_options[:forward_agent] = true

set :pid_path, "#{deploy_to}/shared/pids"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/unicorn.pid"

namespace :deploy do  
  task :stop, :roles => :app do  
  run "cd #{current_path} && kill -QUIT `cat #{pid_path}/unicorn.pid`"  
  end   
  
  task :start, :roles => :app do  
    run "cd #{current_path} && bundle exec unicorn_rails -c config/unicorn.rb -E #{rails_env} -D"  
  end  
    
  task :restart, :roles => :web do  
    run "cd #{current_path}; [ -f #{pid_path}/unicorn.pid ] && kill -USR2 `cat #{pid_path}/unicorn.pid` || bundle exec unicorn_rails -c config/unicorn.rb -E #{rails_env} -D"  
  end
end
