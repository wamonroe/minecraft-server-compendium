module MSC
  def self.settings
    @settings ||= Settings.new
  end

  class Settings
    APP_ID = "msc"
    TRUE_VALUES = %w[true 1 t on yes].freeze

    def initialize
      @env_value = {}
      require "dotenv/load" unless rails_env.production?
    end

    def app_env_name
      rails_env.production? ? APP_ID : "#{APP_ID}_#{rails_env}"
    end

    def ci?
      to_boolean fetch("CI")
    end

    def coverage?
      to_boolean fetch("COVERAGE")
    end

    def db_host
      fetch("DB_HOST", required: true)
    end

    def db_name
      fetch("DB_NAME", app_env_name)
    end

    def db_pass
      fetch("DB_PASS", required: true)
    end

    def db_pool
      fetch("DB_POOL", rails_max_threads).to_i
    end

    def db_user
      fetch("DB_USER", required: true)
    end

    def dev_user_pass
      fetch("DEV_USER_PASS", required: true) # only required in development
    end

    def pidfile
      fetch("PIDFILE", "tmp/pids/server.pid")
    end

    def rails_env
      @rails_env ||= ActiveSupport::EnvironmentInquirer.new(
        fetch("RAILS_ENV", "development").downcase
      )
    end

    def rails_cache_store
      [:redis_cache_store, {url: redis_url}]
    end

    def rails_log_to_stdout?
      to_boolean fetch("RAILS_LOG_TO_STDOUT")
    end

    def rails_max_threads
      fetch("RAILS_MAX_THREADS", 5).to_i
    end

    def rails_min_threads
      fetch("RAILS_MIN_THREADS", rails_max_threads).to_i
    end

    def rails_serve_static_files?
      to_boolean fetch(
        "RAILS_SERVE_STATIC_FILES",
        env_default(true, production: false)
      )
    end

    def redis_host
      fetch("REDIS_HOST", required: true)
    end

    def redis_prefix
      fetch("REDIS_PREFIX", app_env_name)
    end

    def redis_url
      "redis://#{redis_host}:6379/1"
    end

    def stmp_email
      fetch("SMTP_EMAIL", required: true)
    end

    def smtp_host
      fetch("SMTP_HOST", required: true)
    end

    def smtp_pass
      fetch("SMTP_PASS")
    end

    def smtp_port
      fetch("MSC_SMTP_PORT", 1025).to_i
    end

    def smtp_tls
      to_boolean fetch("MSC_SMTP_TLS")
    end

    def smtp_user
      fetch("SMTP_USER")
    end

    def web_concurrency
      fetch("WEB_CONCURRENCY", 1).to_i
    end

    def web_host
      fetch("WEB_HOST", "localhost")
    end

    def web_port
      fetch("WEB_PORT", 3000).to_i
    end

    private

    def env_default(default, options = {})
      options.each do |env_name, env_default|
        if rails_env == env_name.to_s.downcase
          return env_default
        end
      end
      default
    end

    def fetch(env_var, default = nil, required: false)
      @env_value[env_var] ||= if required
        ENV.fetch(env_var)
      else
        ENV.fetch(env_var, default)
      end
    end

    def to_boolean(value)
      TRUE_VALUES.include?(value.to_s.downcase)
    end
  end
end
