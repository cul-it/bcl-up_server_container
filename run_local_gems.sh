#!/usr/bin/env bash
source "scripts/log_utils.sh"
set -e

###############################################################################
##  Uses local gem `bcl_up_server` and rebuilds the Docker image             ##
## ------------------------------------------------------------------------- ##
## This allows for realtime local development of the bcl-up_server engine    ##
###############################################################################
print_header "💻 Executing run_local_gems.sh"

print_msg "🐳  Composing Docker image to use local gem at '/bcl-up_server'..."
docker compose -f docker-compose-local-gems.yml build --build-arg USE_LOCAL_GEMS=true

print_msg "🐳  Starting Docker Image..."
print_header "🚧 This uses the bcl-up_server gem from your local machine" "🛠️  Changes to the gem will be reflected real-time in app"
docker compose -f docker-compose-local-gems.yml up

