# This script creates a Google Cloud Build trigger for a specified repository.
# Usage: ./create-trigger.sh <PROJECT_ID>
#
# Arguments:
#   PROJECT_ID: The ID of the Google Cloud project where the trigger will be created.
#
# Prompts:
#   REPO_URL: The URL of the repository where the trigger will be set up.
#   BRANCH_NAME: The branch name pattern for the trigger.
#   TRIGGER_NAME: The name of the trigger to be created.
#   BUILD_FILE: The path to the cloudbuild.yaml file.
#   SUBSTITUTIONS: Key-value pairs for substitutions in the format key=value,comma-separated.
#
# Example:
#   ./create-trigger.sh my-gcp-project
#   Enter repository URL: https://source.developers.google.com/p/my-gcp-project/r/my-repo
#   Enter branch name for trigger: ^main$
#   Enter trigger name: my-trigger
#   Enter path to cloudbuild.yaml: /path/to/cloudbuild.yaml
#   Enter substitutions (key=value,comma-separated): _KEY1=value1,_KEY2=value2
#
# This script uses the gcloud command to create a Cloud Build trigger with the specified parameters.
#!/bin/bash


PROJECT_ID=$1

read -p "Enter repository URL: " REPO_URL
read -p "Enter branch name for trigger: " BRANCH_NAME
read -p "Enter trigger name: " TRIGGER_NAME
read -p "Enter path to cloudbuild.yaml: " BUILD_FILE
read -p "Enter substitutions (key=value,comma-separated): " SUBSTITUTIONS

echo "Creating Cloud Build trigger '$TRIGGER_NAME'..."

gcloud beta builds triggers create cloud-source-repositories \
  --project="$PROJECT_ID" \
  --name="$TRIGGER_NAME" \
  --repo="$REPO_URL" \
  --branch-pattern="$BRANCH_NAME" \
  --build-config="$BUILD_FILE" \
  --substitutions="$SUBSTITUTIONS"

echo "Trigger '$TRIGGER_NAME' created successfully!"
