#!/bin/bash

# validate_project_id() - Validates if the given Google Cloud project ID exists.
# Arguments:
#   $1 - The Google Cloud project ID to validate.
# Outputs:
#   Prints an error message and exits with status 1 if the project does not exist.
# Example:
#   validate_project_id "my-gcloud-project"

# check_service_enabled() - Checks if a specific Google Cloud service is enabled for a given project.
# If the service is not enabled, it enables the service.
# Arguments:
#   $1 - The Google Cloud service to check (e.g., "compute.googleapis.com").
#   $2 - The Google Cloud project ID.
# Outputs:
#   Prints a message indicating whether the service is already enabled or if it is being enabled.
# Example:
#   check_service_enabled "compute.googleapis.com" "my-gcloud-project"

validate_project_id() {
  PROJECT_ID=$1
  if ! gcloud projects describe "$PROJECT_ID" &>/dev/null; then
    echo "Error: Project '$PROJECT_ID' does not exist."
    exit 1
  fi
}

check_service_enabled() {
  SERVICE=$1
  PROJECT_ID=$2
  if ! gcloud services list --enabled --project="$PROJECT_ID" | grep -q "$SERVICE"; then
    echo "Service '$SERVICE' is not enabled. Enabling it now..."
    gcloud services enable "$SERVICE" --project="$PROJECT_ID"
  else
    echo "Service '$SERVICE' is already enabled."
  fi
}
