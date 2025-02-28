require 'logger' # Fixes uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger (NameError)

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
