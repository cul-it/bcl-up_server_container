# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.2'

gem 'aws-sdk-s3', '~> 1.143'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.16', require: false
gem 'coffee-rails', '~> 5.0.0'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.10'
gem 'lograge'
gem 'mysql2'
gem 'puma', '>= 5.6.4', '~>6.4.0'
gem 'rails', '~> 7.0.8'
gem 'sass-rails', '~> 5.0'
# gem 'sqlite3'
gem "sqlite3", "~> 1.6"

gem 'drb'
gem 'mutex_m'
gem 'swagger-docs'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

## Gems manually added to for qa and qa_server engines
# Required gems for QA and linked data access
# gem 'qa_server', '~> 8.0'
gem 'bcl_up_server', git: 'https://github.com/cul-it/bcl-up_server', branch: 'main'
gem 'linkeddata'
gem 'psych', '~> 5.1'
gem 'qa', '~> 5.10'

group :development do
  gem 'better_errors' # add command line in browser when errors
  gem 'binding_of_caller' # deeper stack trace used by better errors
  gem 'bixby', '~> 5.0' # style guide enforcement with rubocop
  gem 'listen', '>= 3.0.5', '< 3.9'
  gem 'rubocop-checkstyle_formatter', require: false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 3.35'
  gem 'capybara-screenshot', '~> 1.0'
  # gem 'chromedriver-helper'

  gem 'coveralls', require: false
  gem 'factory_bot', '~> 4.4'
  gem 'factory_bot_rails', '~> 4.4', require: false
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-activemodel-mocks', '~> 1.0'
  gem 'rspec-its', '~> 1.1'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '~> 5.1'
  gem 'selenium-webdriver'
  gem 'webdrivers', '~> 4.4'
  gem 'webmock'

  # Easy installation and use of web drivers to run system tests with browsers
  gem "simplecov", require: false
  gem "simplecov-rcov", require: false
end

group :development, :integration, :test do
  gem 'byebug' # debugging
end

group :development, :integration do
  # gem 'xray-rails' # overlay showing which files are contributing to the UI
  # This gem doesn't work with Ruby 3.x unless a special branch is used (see
  # https://github.com/brentd/xray-rails/pull/108). There is a PR to merge the fix
  # into the master branch, but the gem's authors don't seem to be in a hurry to
  # finish the work.
  gem 'xray-rails', git: 'https://github.com/brentd/xray-rails.git', branch: 'bugs/ruby-3.0.0'
end
