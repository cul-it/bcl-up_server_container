# frozen_string_literal: true
BclUpServer.config do |config|
  # Preferred time zone for reporting historical data and performance data
  # @param [String] time zone name
  # @see https://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html for possible values of TimeZone names
  config.preferred_time_zone_name = ENV['PREFERRED_TIME_ZONE_NAME'] || 'Eastern Time (US & Canada)'

  # Preferred hour to expire caches related to slow running calculations (e.g. monitoring tests, performance data)
  # @param [Integer] count of hours from midnight (0-23 with 0=midnight)
  # @example
  #   For preferred_time_zone_name of 'Eastern Time (US & Canada)', use 3 for slow down at midnight PT/3am ET
  #   For preferred_time_zone_name of 'Pacific Time (US & Canada)', use 0 for slow down at midnight PT/3am ET
  config.hour_offset_to_expire_cache = 3

  # Displays a graph of historical test data when true
  # @param [Boolean] display history graph when true
  config.display_historical_graph = false

  # Displays a datatable of historical test data when true
  # @param [Boolean] display history datatable when true
  config.display_historical_datatable = ActiveModel::Type::Boolean.new.cast(ENV['DISPLAY_HISTORICAL_DATA'] || true)

  # Historical datatable default time period.
  # @param [Symbol] time period for calculating historical pass/fail (i.e., one of :month, :year, or :all)
  config.historical_datatable_default_time_period = ENV['HISTORICAL_DATA_DEFAULT_TIME_PERIOD']&.to_sym || :year

  # Displays a graph of performance test data when true
  # @param [Boolean] display performance graph when true
  config.display_performance_graph = ActiveModel::Type::Boolean.new.cast(ENV['DISPLAY_PERFORMANCE_GRAPH'] || false)

  # Displays a datatable of performance test data when true
  # @param [Boolean] display performance datatable when true
  config.display_performance_datatable = ActiveModel::Type::Boolean.new.cast(ENV['DISPLAY_PERFORMANCE_DATATABLE'] || true)

  # Performance graph default time period for all graphs.  All authorities will show the graph for this time period on page load.
  # @param [String] :day, :month, or :year
  config.performance_graph_default_time_period = ENV['PERFORMANCE_DATA_DEFAULT_TIME_PERIOD']&.to_sym || :month

  # Performance datatable default time period for calculating stats.
  # @param [String] :day, :month, :year, :all
  config.performance_datatable_default_time_period = ENV['PERFORMANCE_DATA_DEFAULT_TIME_PERIOD']&.to_sym || :month

  # Max time in milliseconds for y-axis in the performance graphs.
  # @param [Integer] milliseconds
  # config.performance_y_axis_max = 4000

  # Color of the graph line for retrieve times in the performance graphs.
  # @param [String] color RGB code
  # @note The default colors for the retrieve, graph_load, load, normalization, and full request lines in the performance graph are accessible.
  # config.performance_retrieve_color = '#ABC3C9'

  # Color of the graph line for graph load times in the performance graphs.
  # @param [String] color RGB code
  # @note The default colors for the retrieve, graph_load, normalization, and full request lines in the performance graph are accessible.
  # config.performance_graph_load_color = '#E8DCD3'

  # Color of the graph line for normalization times in the performance graphs
  # @param [String] color RGB code
  # @note The default colors for the retrieve, graph_load, load, normalization, and full request lines in the performance graph are accessible.
  # config.performance_normalization_color = '#CCBE9F'

  # Performance datatable targeted maximum full request time.
  # @param [Integer] targeted maximum full request time in ms
  # config.performance_datatable_max_threshold = 1500

  # Performance datatable targeted warning full request time.
  # @param [Integer] targeted warning full request time in ms
  # config.performance_datatable_warning_threshold = 1000

  # Additional menu items to add to the main navigation menu's set of left justified menu items
  # @param [Array<Hash<String,String>>] array of menu items to append with hash label: is menu item label to display and hash url: is URL for the menu item link
  config.navmenu_extra_leftitems = [
    { label: 'API Documentation', url: '/qa/apidoc/' }
  ]

  # Performance data is gathered on every incoming query.  If load is high, this can have a negative performance
  # impact and may need to be suppressed.  Performance stats will not be gathered when this config is true.
  # @param [Boolean] do not gather performance data when true (defaults to false for backward compatibitily)
  config.suppress_performance_gathering = ActiveModel::Type::Boolean.new.cast(ENV['SUPPRESS_PERFORMANCE_LOGGING'] || true)

  # Performance data is gathered on every incoming query.  Basic stats are logged from QA.  Full stats are logged
  # by BclUpServer and can eat up logging realestate.  To suppress the logging of details, set this config to true.
  # @param [Boolean] do not log performance data details when true (defaults to false for backward compatibitily)
  config.suppress_logging_performance_details = ActiveModel::Type::Boolean.new.cast(ENV['SUPPRESS_PERFORMANCE_LOGGING'] || true)

  # Maximum amount of memory the performance cache can occupy before it is written to the database.
  # @param [Integer] maximum size of performance cache before flushing
  # config.max_performance_cache_size = 32GB

  # Enable/Disable logging of performance cache
  # Uncomment one of the lines below to enable or disable performance cache logging.  NOTE: By default, loggers follow the
  # default levels for Rails loggers (i.e. enabled for development, disabled for production.)
  # config.enable_performance_cache_logging
  # config.disable_performance_cache_logging
  config.enable_performance_cache_logging if ActiveModel::Type::Boolean.new.cast(ENV['PERFORMANCE_CACHE_LOGGING_ENABLED'] || false)

  # Enable/Disable logging of monitoring process
  # Uncomment one of the lines below to enable or disable monitoring process logging.  NOTE: By default, loggers follow the
  # default levels for Rails loggers (i.e. enabled for development, disabled for production.)
  # config.enable_monitor_status_logging
  # config.disable_monitor_status_logging
  config.enable_monitor_status_logging if ActiveModel::Type::Boolean.new.cast(ENV['MONITOR_STATUS_LOGGING_ENABLED'] || false)
end
