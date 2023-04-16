require "test_helper"

# WORK AROUND - SimpleCov 0.19.0
# Trick SimpleCov that each parallel run is just another command and merge results. Hopefully
# SimpleCov will natively support this in the future and this can be removed.
SimpleCov.command = "test:system"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
