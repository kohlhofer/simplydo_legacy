set :application, "simplydo"
set :deploy_to, "/var/www/apps/#{application}"
set :domain, "danielsteiner.de"

set :user, 'steini'

set :ssh_options, {:forward_agent => true}
set :use_sudo, false

default_run_options[:pty] = true

set :scm, "git"
set :branch, "master"
set :repository, "git://github.com/kohlhofer/simplydo.git "
set :keep_releases, 5
set :git_enable_submodules, 1
set :deploy_via, :remote_cache

role :web, domain
role :app, domain
role :db, domain, :primary => true

task :after_update_code, :roles => :app do
  db_config = "#{shared_path}/config/database.yml"
  run "cp #{db_config} #{release_path}/config/database.yml"
  run "ln -s /home/steini/rails_edge #{release_path}/vendor/rails"
end
namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end