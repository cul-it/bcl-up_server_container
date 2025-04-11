#!/bin/bash
source "scripts/log_utils.sh"

print_header "AWS Environment Settings"
print_msg "Selected ENV file for ECS: ${ENV_FILE_S3}"
print_msg "AWS Task Definition Used: ${TASK_DEFINITION_NAME}"

print_header "Building Docker image"
./build.sh -r container_env_latest.env

print_header "Created Image From ./build.sh"
print_msg "IMG_SHA = ${IMG_SHA}"
print_msg "IMG_LATEST = ${IMG_LATEST}"

print_header "Pushing Docker Image to ECR"
# Tag the image with both `:latest` and the commit-specific tag
docker tag bcl-up_server_container:latest ${IMG_SHA}
docker tag bcl-up_server_container:latest ${IMG_LATEST}

# Inspect Images
docker inspect ${IMG_SHA}
docker inspect ${IMG_LATEST}

# Push both tags to ECR
docker push ${IMG_SHA}
docker push ${IMG_LATEST}

docker logout

print_header "Deploying Docker Container in ECS"
print_msg    "Deployed With Task Definition: ${TASK_DEFINITION_NAME}"

aws ecs update-service \
  --cluster dcp-dev \
  --service dcp-dev \
  --task-definition "${TASK_DEFINITION_NAME}" \
  --force-new-deployment