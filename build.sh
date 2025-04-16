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

compose_file=""
environment="development"
precompile_assets="false"
while getopts "pe:" options; do
  case "${options}" in
    e) environment="${OPTARG}" ;;
    p) precompile_assets="true" ;;
    *) exit_abnormal ;;
  esac
done

print_msg "🛠️  Updating bcl_up_server gem from Git..."
bundle update bcl_up_server

if [ ${environment} == "development" ]; then
  export compose_file="docker-compose.yml"
elif [ ${environment} == "integration" ]; then
  export compose_file="docker-compose-int.yml"
elif [ ${environment} == "production" ]; then
  export compose_file="docker-compose-prod.yml"
else
  print_error "❌ Invalid environment specified. Use 'development', 'integration' , or 'production'."
  exit 1
fi

print_msg "🐳  Building Docker image with the following command..."
print_msg "🐳  docker compose -f ${compose_file} build --build-arg PRECOMPILE_ASSETS=${precompile_assets} --build-arg RAILS_ENV=${environment}"
docker compose -f ${compose_file} build --build-arg PRECOMPILE_ASSETS=${precompile_assets} --build-arg RAILS_ENV=${environment}
unset compose_file
print_msg "🐳  Docker image built successfully."
