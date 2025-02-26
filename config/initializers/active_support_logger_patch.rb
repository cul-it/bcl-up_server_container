# Fixes uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger (NameError)
if defined?(ActiveSupport::LoggerThreadSafeLevel)
  require 'logger' unless defined?(Logger)
  module ActiveSupport
    module LoggerThreadSafeLevel
      Logger = ::Logger unless defined?(Logger)
    end
  end
end
