source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Authentication and authorization
gem 'devise'
gem 'devise_invitable'

# Drivers
gem 'pg'
gem 'puma', '~> 4.1'
gem 'redis', '~> 4.0'

# JavaScript and assets
gem 'inline_svg'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

# Presentation
gem 'draper'

# Other
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem "dotenv"

  # Code formating and linting
  gem "erb_lint", require: false
  gem "htmlbeautifier", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "standard", require: false
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'mocha'
  gem 'selenium-webdriver'
  gem 'shoulda'
  gem 'simplecov', require: false
  gem 'webdrivers'
end
