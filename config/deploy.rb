# configure bundler
require 'bundler/capistrano'
set :bundle_without,  [:development, :test, :heroku]

# configure multiple stages
set :stages, %w(vagrant prototype production)
set :default_stage, "prototype"
require 'capistrano/ext/multistage'

set :application, "gaia"
set :scm, :git
set :repository, "git://github.com/gardym/gaia-pdb.git"
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
  
  def run_rake_task(t)
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake #{t}"
  end
    
  namespace :db do
    
    desc "Drop the database on the remote server"
    task(:drop, :roles => :db) do 
      run_rake_task("db:drop")
    end
    
    desc "Create the database on the remove server"
    task(:create, :roles => :db) do
      run_rake_task("db:create") 
    end
    
    desc "Seed the database with test data"
    task(:seed, :roles => :db) do
      run_rake_task("db:seed")
    end
    
    desc "Create, migrate and seed the database on the remove server"
    task(:test_setup, :roles => :db) { } 
    after "deploy:db:test_setup", "deploy:db:create", "deploy:migrate", "deploy:db:seed"
    
  end
  
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
