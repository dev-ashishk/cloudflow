# This script checks and assigns specific IAM roles to a Google Cloud project.
# 
# Usage:
#   ./check-roles.sh <PROJECT_ID>
#
# Arguments:
#   PROJECT_ID: The ID of the Google Cloud project to check and assign roles.
#
# Description:
#   The script checks if the specified IAM roles are already assigned to the project.
#   If any role is missing, it assigns the role to the project's Cloud Build service account.
#
# IAM Roles Checked:
#   - roles/cloudbuild.builds.editor
#   - roles/secretmanager.secretAccessor
#
# Example:
#   ./check-roles.sh my-gcp-project
#
# Note:
#   Ensure that you have the necessary permissions to view and modify IAM policies
#   for the specified project.
#!/bin/bash

PROJECT_ID=$1

ROLES=("roles/cloudbuild.builds.editor" "roles/secretmanager.secretAccessor")

echo "Checking IAM roles for project $PROJECT_ID..."

for ROLE in "${ROLES[@]}"; do
  if gcloud projects get-iam-policy "$PROJECT_ID" --filter="bindings.role=$ROLE" | grep -q "cloudbuild"; then
    echo "Role '$ROLE' is already assigned."
  else
    echo "Role '$ROLE' is missing. Adding it now..."
    gcloud projects add-iam-policy-binding "$PROJECT_ID" \
      --member="serviceAccount:$PROJECT_ID@cloudbuild.gserviceaccount.com" \
      --role="$ROLE"
  fi
done

echo "IAM roles check completed!"
