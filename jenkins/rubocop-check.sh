#!/bin/bash
set -e
set +x
source scripts/log_utils.sh
source jenkins/environment.sh

print_header "Executing rubocop-check.sh"
print_msg "PATH: $PATH"

print_list "$(
  echo "pwd: $(pwd)"
  ls -l
)"

print_msg "Running RuboCop..."
bundle exec rubocop
