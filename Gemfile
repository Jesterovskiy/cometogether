source 'https://rubygems.org'

BUNDLE_RAILS_VERSION = '~> 4.2.4'

# Rails
gem 'railties',      BUNDLE_RAILS_VERSION
gem 'activerecord',  BUNDLE_RAILS_VERSION
gem 'activesupport', BUNDLE_RAILS_VERSION
gem 'actionpack',    BUNDLE_RAILS_VERSION

# API
gem 'rails-api'

# Database
gem 'pg'

# Optimizations
gem 'oj'
gem 'oj_mimic_json'

# Metrics
gem 'thor'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Documentation presetner
gem 'apitome'

# Authorization
gem 'pundit'

group :development, :test do
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'

  gem 'rspec_api_documentation'
end

group :development do
  gem 'binding_of_caller'
  gem 'better_errors'
end

group :test do
  gem 'rspec-rails'

  gem 'ffaker'
  gem 'fabrication'
  gem 'database_cleaner'
  gem 'webmock'

  gem 'rack-test', require: 'rack/test'
end

group :metrics do
  gem 'simplecov'
  gem 'reek'
  gem 'rubocop'
end
