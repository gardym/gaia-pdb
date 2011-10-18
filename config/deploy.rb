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

set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do 
    run "cd #{current_path} && bundle exec unicorn_rails -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do 
    run "if [ -f #{unicorn_pid} ] ; then cd #{current_path} && #{try_sudo} kill `cat #{unicorn_pid}` ; fi"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ] ; then cd #{current_path} && #{try_sudo} kill -s QUIT `cat #{unicorn_pid}` ; fi"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ] ; then cd #{current_path} && #{try_sudo} kill -s USR2 `cat #{unicorn_pid}` ; fi"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end
