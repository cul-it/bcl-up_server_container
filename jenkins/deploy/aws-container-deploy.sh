#!/bin/bash
#############################
## TODO: Work in Progress  ##
########################################################################
## Currently a stub for the deploy script pattern already used. Will  ##
## implement in future feature branch for deploying to ECS.           ##
########################################################################

source "scripts/log_utils.sh"

print_header "AWS Environment Settings"
print_msg "AWS Task Definition Used: ${TASK_DEFINITION_NAME}"

print_header "Building Docker image for ${RAILS_ENV} environment"
./build.sh -pe ${RAILS_ENV}

print_header "Created Image From ./build.sh"
print_msg "IMG_LATEST = ${IMG_LATEST}"
print_msg "AWS_IMG_LATEST = ${AWS_IMG_LATEST}"

print_header "Pushing Docker Image to ECR"
docker tag ${IMG_LATEST} ${AWS_IMG_LATEST}

# Inspect Images
docker inspect ${AWS_IMG_LATEST}

# Push both tags to ECR
docker push ${AWS_IMG_LATEST}

docker logout

print_header "Deploying Docker Container in ECS"
print_msg    "Deployed With Task Definition: ${TASK_DEFINITION_NAME}"

aws ecs update-service \
  --cluster "${ECS_CLUSTER}" \
  --service "${ECS_SERVICE}" \
  --task-definition "${TASK_DEFINITION_NAME}" \
  --force-new-deployment