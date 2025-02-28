#!/bin/bash

# ==============================================================================
# This script runs RSpec tests inside a Docker container.
# It detects the running Rails container and runs tests for both:
# - The Rails application
# - The bcl_up_server gem inside the container
# ------------------------------------------------------------------------------
# Usage:
#   ./run_tests.sh                 # Runs all tests (app + gem)
#   ./run_tests.sh spec/path/to/test_file_spec.rb  # Runs a specific test file
# ==============================================================================

# Find the running container name that matches "web" or "app"
CONTAINER_NAME=$(docker ps --format "{{.Names}}" | grep -E '(web|app)')

# If no container is found, exit with an error
if [ -z "$CONTAINER_NAME" ]; then
  echo "🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴"
  echo "🔴 No running Rails container found. Make sure it's running!"
  echo "🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴"
  echo ""
  exit 1
fi
echo ""
echo "🟢 Running RSpec tests inside the container: $CONTAINER_NAME"
echo ""
# Ensure Bundler is available
echo "🚀 Checking if Bundler is installed..."
docker exec -it $CONTAINER_NAME sh -c "which bundle || gem install bundler"

# Run RSpec tests for the Rails app
echo "🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪"
echo "🧪 Running RSpec tests for bcl-up_server_container..."
echo "🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪"
echo ""

docker exec -it $CONTAINER_NAME /usr/local/bin/bundle exec rspec "$@"

GEM_PATH=$(docker exec -it $CONTAINER_NAME sh -c "bundle show bcl_up_server" 2>/dev/null | tr -d '\r' | tr -d '\n')

# If the gem path is empty, exit with an error
if [ -z "$GEM_PATH" ]; then
  echo "🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴"
  echo "🔴 bcl_up_server gem not found inside the container!"
  echo "🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴"
  echo ""
  exit 1
fi

echo ""
echo "🟢 Found bcl_up_server gem at: $GEM_PATH"
echo ""

# Run tests for the bcl_up_server gem
echo "🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪"
echo "🧪 Running tests for the bcl_up_server gem..."
echo "🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪🧪"
echo ""

docker exec -it $CONTAINER_NAME sh -c "
  cd $GEM_PATH &&
  bundle install &&
  bundle exec rake test_gem
"
echo ""
echo ""
echo "✅✅✅✅✅✅✅✅✅✅✅✅✅"
echo "✅ All tests completed!"
echo "✅✅✅✅✅✅✅✅✅✅✅✅✅"
echo ""
echo ""