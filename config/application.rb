require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require 'active_storage/engine'
require "action_controller/railtie"
require "action_mailer/railtie"
# require 'action_mailbox/engine'
# require 'action_text/engine'
require "action_view/railtie"
# require 'action_cable/engine'
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MSC
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # We use environment variables to pass in secrets into rails instead of
    # encrypting them and storing them in the repo. Disable the check for
    # ENV["RAILS_MASTER_KEY"]
    config.require_master_key = false

    # Enable/disable serving static files from the `/public` folder. Apache or
    # NGINX already handle this, so consider disabling in production.
    config.public_file_server.enabled = MSC.settings.rails_serve_static_files?

    # Use default logging formatter so that PID and timestamp are not suppressed.
    config.log_formatter = ::Logger::Formatter.new

    # Enable/disable logging to STDOUT
    if MSC.settings.rails_log_to_stdout?
      logger = ActiveSupport::Logger.new($stdout)
      logger.formatter = config.log_formatter
      config.logger = ActiveSupport::TaggedLogging.new(logger)
    end

    # Action Mailer settings
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: MSC.settings.smtp_host,
      port: MSC.settings.smtp_port,
      user_name: MSC.settings.smtp_user,
      password: MSC.settings.smtp_pass,
      authentication: "plain",
      enable_starttls_auto: MSC.settings.smtp_tls
    }
    config.action_mailer.default_url_options = {
      host: MSC.settings.web_host,
      port: MSC.settings.web_port
    }

    # Generator settings
    config.generators do |g|
      # Disable assets
      g.assets false

      # Disable helpers
      g.helper false

      # Set primary key type to UUID
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
