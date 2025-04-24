#!/usr/bin/env bash
# ! /bin/sh
source "scripts/log_utils.sh"

print_header "⚙️  RUNNING BCL UP SERVER" "From bcl_up_server_container 🐳 image: $(< ./VERSION)"

set -e

sh ./bin/setup_env.sh

# Wait for DB services
# sh ./bin/db-wait.sh

# Prepare DB (Migrate if exists; else Create db & Migrate)
sh ./bin/db-prepare.sh

# Pre-compile app assets
# sh ./bin/asset-pre-compile.sh

# For development check if the gems as installed. If not, install them.
# sh ./bin/bundle-gems.sh

# Remove a potentially pre-existing server.pid for Rails
# rm -f /app/tmp/pids/server.pid

export RAILS_LOG_TO_STDOUT="1"

# Run the command defined in docker-compose.yml
bundle exec puma -v -b tcp://0.0.0.0:3000
