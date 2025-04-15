#!/bin/bash
source "scripts/log_utils.sh"

###############################################################################
## Updates the Git-based gem `bcl_up_server` and rebuilds the Docker image   ##
## ------------------------------------------------------------------------- ##
## This ensures that the Gemfile.lock is always using the latest commit from ##
## main before Docker builds, avoiding stale references and rebuild bugs.    ##
###############################################################################
print_header "💻 Executing build.sh"

print_msg "🛠️  Updating bcl_up_server gem from Git..."
bundle update bcl_up_server

print_msg "🐳  Building Docker image..."
#docker compose build
docker compose build --build-arg PRECOMPILE_ASSETS=false
