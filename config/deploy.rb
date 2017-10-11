# config valid only for current version of Capistrano
lock '3.7.2'

set :application, 'codeforelection_front'
set :repo_url, 'https://github.com/codeforjapan/codeforelection_front.git'

# rvmの設定
set :rvm_type, :system
set :rvm1_ruby_version, '2.4.2'

#set :rbenv_ruby, '2.4.2'
#set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
#set :rbenv_map_bins, %w{rake gem bundle ruby rails}
#set :rbenv_roles, :all

# Default branch is :master
set :branch, 'production'

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :warn

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'Seeds database'
  task :seed do
    on roles(:app) do
      within release_path do
        execute :bundle, :exec, :"rails db:seed RAILS_ENV=#{fetch(:stage)}"
      end
    end
  end

  desc 'graydb impport'
  task :graydb_import do
    on roles(:app) do
      within release_path do
        execute :bundle, :exec, :"rake graydb:import RAILS_ENV=#{fetch(:stage)}"
      end
    end
  end
  after :publishing, :restart
  after :finished, 'deploy:seed'

end
