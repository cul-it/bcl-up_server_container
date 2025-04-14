#!/bin/bash
# ==============================================================================
# Updates the Git-based gem `bcl_up_server` and rebuilds the Docker image
# ------------------------------------------------------------------------------
# This ensures that the Gemfile.lock is always using the latest commit from main
# before Docker builds, avoiding stale references and rebuild bugs.
# ==============================================================================

echo "🛠️ Updating bcl_up_server gem from Git..."
bundle update bcl_up_server

echo "🐳 Building Docker image..."
#docker compose build
docker compose build --build-arg PRECOMPILE_ASSETS=false
