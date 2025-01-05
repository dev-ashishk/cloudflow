# This script builds and pushes a Docker image to Google Artifact Registry.
#
# Usage:
#   ./build-and-push.sh [environment] [tag]
#
# Arguments:
#   environment: The deployment environment, either "production" or any other value for staging.
#   tag: The tag for the Docker image. If not provided, defaults to "latest".
#
# Environment Variables:
#   PROD_DEST_IMAGE: The destination image name for the production environment.
#
# Steps:
# 1. Set default values and parse arguments.
# 2. Check if the Artifact Registry repository exists, and create it if necessary (only for the "latest" tag).
# 3. Build the Docker image using the specified Dockerfile.
# 4. Push the Docker image to the appropriate Artifact Registry repository based on the environment.
#
# Example:
#   ./build-and-push.sh production v1.0.0
#   ./build-and-push.sh staging

#!/bin/bash

set -e

DOCKERFILE_PATH="deployment/Dockerfile"
IMAGE_NAME="omatime"
REPO_NAME="omatime"
TAG=$2
REGION="us-central1"
PROJECT_ID="collab-time-adef6"


if [ -z "$2" ]; then
  TAG="latest"
fi
SOURCE_IMAGE="${IMAGE_NAME}:${TAG}"

if [[ "$1" == "production" ]]; then
  DEST=$PROD_DEST_IMAGE
  PROJECT_ID="collab-time"
fi
DEST_IMAGE="us-central1-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${SOURCE_IMAGE}"

if [[ "$TAG" == "latest" ]];then
  echo "Checking for Artifact Registry repository..."
  if ! gcloud artifacts repositories describe "$REPO_NAME" --location="$REGION" --project="$PROJECT_ID" &>/dev/null; then
    echo "Artifact Registry repository not found. Creating repository..."
    gcloud artifacts repositories create "$REPO_NAME" \
      --repository-format=docker \
      --location="$REGION" \
      --description="Repository for Docker images" \
      --project="$PROJECT_ID"
  else
    echo "Artifact Registry $REPO_NAME repository already exists."
  fi
else
  echo "Skipping step to create repository"
fi

echo "Building the Docker image..."
docker buildx build -f "$DOCKERFILE_PATH" -t "$DEST_IMAGE" --platform linux/amd64 --no-cache --load .

Step 3: Push the image
if [[ "$1" == "production" ]]; then
  echo "Pushing the Docker image to production: $DEST_IMAGE"
  docker push "$DEST_IMAGE"
else
  echo "Pushing the Docker image to staging: $DEST_IMAGE"
  docker push "$DEST_IMAGE"
fi

echo "Docker image pushed successfully to $DEST_IMAGE"
