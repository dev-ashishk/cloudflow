# This script enables a list of required Google Cloud APIs for a specified project.
# Usage: ./enable-apis.sh <PROJECT_ID>
# Arguments:
#   PROJECT_ID: The ID of the Google Cloud project for which the APIs should be enabled.
# The script enables the following APIs:
#   - Cloud Build API (cloudbuild.googleapis.com)
#   - Artifact Registry API (artifactregistry.googleapis.com)
#   - Secret Manager API (secretmanager.googleapis.com)
# Example:
#   ./enable-apis.sh my-gcp-project
#!/bin/bash

PROJECT_ID=$1

APIS=("cloudbuild.googleapis.com" "artifactregistry.googleapis.com" "secretmanager.googleapis.com")

echo "Enabling required APIs for project $PROJECT_ID..."

for API in "${APIS[@]}"; do
  echo "Enabling $API..."
  gcloud services enable "$API" --project="$PROJECT_ID"
done

echo "APIs enabled successfully!"
