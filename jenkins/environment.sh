#!/bin/bash
set +x
source ../scripts/log_utils.sh
source jenkins/chromedriver-verifier.sh

print_header "Executing environment.sh"

print_msg "Branch: $(git rev-parse --abbrev-ref HEAD)"
print_msg "JENKINS_HOME: $JENKINS_HOME"
#print_msg "Solr: $SOLR_URL"

# Add project bin directory to PATH
PATH=$PWD/bin:$PATH
print_msg "PATH: $PATH"

# Load RVM and use correct Ruby version
source /etc/profile.d/rvm.sh
RUBYVERSION=ruby-3.3.7
print_msg "Ruby: $RUBYVERSION"
GEM_HOME="/usr/local/rvm/gems/$RUBYVERSION"
rvm use "$RUBYVERSION"

# Copy environment file
cp /cul/data/jenkins/environments/bcl-up_server_container.env .env