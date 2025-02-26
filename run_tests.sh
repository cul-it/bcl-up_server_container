#!/bin/bash

# ==============================================================================
# This script runs RSpec tests inside a Docker container.
# It automatically detects the running Rails container.
# ------------------------------------------------------------------------------
# Usage:
#   ./run_tests.sh                 # Runs all tests
#   ./run_tests.sh spec/path/to/test_file_spec.rb  # Runs a specific test file
# ==============================================================================

# Find the running container name that matches "web" or "app"
CONTAINER_NAME=$(docker ps --format "{{.Names}}" | grep -E '(web|app)')

# If no container is found, exit with an error
if [ -z "$CONTAINER_NAME" ]; then
  echo "🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴"
  echo "🔴 No running Rails container found. Make sure it's running  🔴"
  echo "🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴"
  exit 1
fi

echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢"
echo "🟢 Running RSpec tests inside the container: $CONTAINER_NAME 🟢"
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢"

# Run RSpec tests inside the container explicitly using the correct path
docker exec -it $CONTAINER_NAME /usr/local/bin/bundle exec rspec "$@"