source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem "rails", "~> 7.0.4", ">= 7.0.4.3"

# Drivers
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "redis", "~> 4.0"

# Authentication and authorization
gem "devise"
gem "devise_invitable"

# JavaScript and assets
gem "cssbundling-rails"
gem "jsbundling-rails"
gem "sprockets-rails"

# Presentation
gem "draper"

# UI
gem "inline_svg"
gem "stimulus-rails"
# gem "tag_options"
gem "turbo-rails"
# gem "vcfb"
# gem "view_component"

# Other
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem "dotenv"
  gem "pry-byebug", "~> 3.10", ">= 3.10.1"

  # Code formating and linting
  gem "erb_lint", require: false
  gem "htmlbeautifier", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "standard", require: false
end

group :development do
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "mocha"
  gem "selenium-webdriver"
  gem "shoulda"
  gem "simplecov", require: false
  gem "webdrivers"
end
