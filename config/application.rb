require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
# require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require 'action_mailbox/engine'
# require 'action_text/engine'
require 'action_view/railtie'
# require 'action_cable/engine'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MinecraftServerCompendium
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Action Mailer settings
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: ENV.fetch('MSC_SMTP_HOST', 'localhost'),
      port: ENV.fetch('MSC_SMTP_PORT', '1025').to_i,
      user_name: ENV['MSC_SMTP_USER'],
      password: ENV['MSC_SMTP_PASS'],
      authentication: 'plain',
      enable_starttls_auto: ActiveRecord::Type::Boolean.new.cast(ENV['MSC_SMTP_TLS'])
    }
    config.action_mailer.default_url_options = {
      host: ENV.fetch('MSC_HOST', 'localhost'),
      port: ENV.fetch('MSC_PORT', 3000)
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
