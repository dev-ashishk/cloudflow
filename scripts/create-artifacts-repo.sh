# This script creates a new Artifact Registry repository in Google Cloud.
#
# Usage:
#   ./create-artifacts-repo.sh <PROJECT_ID> <REGION>
#
# Arguments:
#   PROJECT_ID  The ID of the Google Cloud project where the repository will be created.
#   REGION      The region where the repository will be created.
#
# The script will prompt the user to enter the name of the repository.
#
# Example:
#   ./create-artifacts-repo.sh my-gcp-project us-central1
#
# This will create a new Artifact Registry repository in the 'us-central1' region
# under the 'my-gcp-project' project.
#!/bin/bash

PROJECT_ID=$1
REGION=$2

read -p "Enter repository name: " REPO_NAME

echo "Creating Artifact Registry repository '$REPO_NAME' in region '$REGION'..."

gcloud artifacts repositories create "$REPO_NAME" \
  --repository-format=docker \
  --location="$REGION" \
  --project="$PROJECT_ID"

echo "Artifact Registry repository '$REPO_NAME' created successfully!"
