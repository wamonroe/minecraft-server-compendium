require_relative "../config/settings"

if MSC.settings.coverage?
  require "simplecov"

  SimpleCov.start "rails" do
    enable_coverage :branch

    add_group "Decorators", "app/decorators"
  end
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    include Devise::Test::IntegrationHelpers

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # WORK AROUND - SimpleCov 0.19.0
    # Trick SimpleCov that each parallel run is just another command and merge
    # results. Hopefully SimpleCov will natively support this in the future and
    # this can be removed.
    if MSC.settings.coverage?
      parallelize_setup do |worker|
        SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}"
      end

      parallelize_teardown do
        SimpleCov.result
      end
    end

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
    # order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

# Enable Shoulda Matchers
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
