require "yaml"

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = MSC.settings.rails_max_threads
min_threads_count = MSC.settings.rails_min_threads
threads min_threads_count, max_threads_count

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
#
worker_timeout 3600 if MSC.settings.rails_env.development?

# Specifies the `environment` that Puma will run in.
#
environment MSC.settings.rails_env

# Specifies the `directory` that Puma will run the application from
app_dir = File.expand_path("..", __dir__)
tmp_dir = "#{app_dir}/tmp"
directory app_dir

# Specifies the `pidfile` that Puma will use.
pidfile MSC.settings.pidfile

if MSC.settings.rails_env.production?
  # Set up socket location
  bind "unix://#{tmp_dir}/sockets/puma.sock"

  # Specifies the number of `workers` to boot in clustered mode.
  # Workers are forked web server processes. If using threads and workers together
  # the concurrency of the application would be max `threads` * `workers`.
  # Workers do not work on JRuby or Windows (both of which do not support
  # processes).
  #
  workers MSC.settings.web_concurrency

  if workers_count > 1
    # Load database configuration
    db_cfg = YAML.load_file("config/database.yml")["production"]

    workers workers_count

    # Use the `preload_app!` method when specifying a `workers` number.
    # This directive tells Puma to first boot the application and load code
    # before forking the application. This takes advantage of Copy On Write
    # process behavior so workers use less memory.
    #
    preload_app!

    before_fork do
      ActiveRecord::Base.connection_pool.disconnect!
    end

    on_worker_boot do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.establish_connection(db_cfg)
      end
    end
  end
else
  # Specifies the `port` that Puma will listen on to receive requests; default is 3000.
  port MSC.settings.web_port

  # Allow puma to be restarted by `rails restart` command.
  plugin :tmp_restart
end
