#!/bin/bash
# bundler for automated tests
source "scripts/log_utils.sh"
set -e
#cd bcl-up_server_container
source jenkins/environment.sh

print_header "Executing prelude.sh"

# Clean up existing Bundler installations
#print_msg "Cleaning up existing Bundler installations"
#gem uninstall bundler -aIx
#
## Reinstall Bundler without documentation
#print_msg "Installing Bundler -v 2.4.10"
#gem install bundler -v 2.4.10 --no-document

# Ensure the PATH includes the directory where Bundler is installed
export PATH=$GEM_HOME/bin:$PATH

# Force native gem compilation (avoid incompatible precompiled binaries with GLIBC)
bundle config set force_ruby_platform true
# Force use sqlite version in jenkins
bundle config build.sqlite3 --with-sqlite3-dir=/usr

# Verify Bundler installation
print_msg "which bundle: $(which bundle)"
print_msg "bundle --version: $(bundle --version)"

# Install dependencies
bundle install

# Set the environment for the test database
print_msg "Setting environment for the test database"
bin/rails db:environment:set RAILS_ENV=${RAILS_ENV}

# Conditionally delete and recreate the database
if [ "${DELETE_DATABASE}" = "true" ]; then
  print_msg "Deleting and recreating the database"
  bundle exec rake db:drop db:create
fi

# Run database migrations
print_msg "Running database migrations"
bundle exec rake db:migrate
