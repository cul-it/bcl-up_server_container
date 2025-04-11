#!/bin/bash
set -e
set +x
source scripts/log_utils.sh
cd bcl-up_server_container
source jenkins/environment.sh

print_header "Executing rspec-tests.sh"
print_msg "PATH: $PATH"
print_msg "Solr: $SOLR_URL"
print_list "$(
  echo "pwd: $(pwd)"
  ls -l
)"
print_msg "Running all rspec tests..."
COVERAGE=true bundle exec rspec
