require 'bundler/capistrano'
require './config/boot'

default_run_options[:pty] = true

set :application, 'lndry'
set :scm,         :git
set :repository,  'git@github.com:psobot/lndry.git'
set :deploy_via,  :remote_cache
set :user,        'psobot'
set :use_sudo,    false
set :keep_releases, 2
# Remove No such file/directory warnings.
set :normalize_asset_timestamps, false

task :production do
  set :rails_env,   'production'
  set :domain,      "petersobot.com"
  set :deploy_to,   "/var/www/lndr.me"
  set :branch,      'master'
  role :app,  domain
  role :web,  domain
  role :db,   domain, :primary => true
  set :whenever_environment, 'production'
end

set :whenever_command, 'bundle exec whenever'
require 'whenever/capistrano'

namespace :deploy do
  task :start do ; end
  task :stop  do ; end
  
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{release_path}/tmp/restart.txt"
  end
  
  task :apply_configs, :roles => :app do
    run "cp #{shared_dir}/database.yml #{release_path}/config/database.yml"
    run "cp #{shared_dir}/settings.yml #{release_path}/config/settings.yml"
  end
  
  task :create_branch_file, :roles => :app, :except => { :no_symlink => true } do
    run "echo #{branch} > #{release_path}/config/.git_branch"
  end  
end

after 'deploy:update_code', 'deploy:apply_configs'
after 'deploy:update_code', 'deploy:create_branch_file'
after 'deploy', 'deploy:cleanup'
