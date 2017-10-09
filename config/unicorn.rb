# -*- encoding : utf-8 -*-
# full_app_name = '<%= fetch(:full_app_name) %>'
APP_PATH   = "#{File.dirname(__FILE__)}/.." unless defined?(APP_PATH)
RAILS_ROOT = "#{File.dirname(__FILE__)}/.." unless defined?(RAILS_ROOT)
RAILS_ENV  = ENV['RAILS_ENV'] || 'development'

worker_processes 3

listen "unix:#{RAILS_ROOT}/tmp/sockets/unicorn.sock"
pid "#{RAILS_ROOT}/tmp/pids/unicorn.pid"

preload_app true

timeout 60
working_directory APP_PATH

# log
stderr_path "#{RAILS_ROOT}/log/unicorn_error.log"
stdout_path "#{RAILS_ROOT}/log/unicorn_access.log"

if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = APP_PATH + "/Gemfile"
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{ server.config[:pid] }.oldbin"
  unless old_pid == server.pid
    begin
      Process.kill :QUIT, File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH

    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
