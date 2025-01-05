# This script creates Google Cloud secrets either from a .env file or manually.
# Usage: ./create-secrets.sh <PROJECT_ID>
#
# Arguments:
#   PROJECT_ID: The Google Cloud project ID where the secrets will be created.
#
# The script prompts the user to choose between creating secrets from a .env file or manually.
#
# If the user chooses to create secrets from a .env file:
#   - The script prompts for the path to the .env file.
#   - The script prompts for an optional prefix for the secrets.
#   - The script prompts for optional labels for the secrets in key=value,comma-separated format.
#   - The script then calls itself with the provided .env file, project ID, prefix, and labels.
#
# If the user chooses to create secrets manually:
#   - The script enters a loop where it prompts for the secret key and value.
#   - The secret key is converted to uppercase to form the secret name.
#   - The script creates the secret in Google Cloud Secret Manager with automatic replication policy.
#   - The script adds an IAM policy binding to allow the Cloud Build service account to access the secret.
#   - The loop continues until the user chooses not to create another secret.
#
# The script outputs a message when the secrets creation process is completed.
#!/bin/bash

PROJECT_ID=$1

read -p "Do you want to create secrets from a .env file? (y/n): " CREATE_FROM_ENV

if [[ "$CREATE_FROM_ENV" == "y" ]]; then
  read -p "Enter path to the .env file: " ENV_FILE
  read -p "Enter prefix for the secrets (optional): " PREFIX
  read -p "Enter labels for secrets (key=value,comma-separated, optional): " LABELS
  
  ./create-secrets.sh "$ENV_FILE" "$PROJECT_ID" "$PREFIX" "$LABELS"
else
  while true; do
    read -p "Enter the secret key: " KEY
    read -p "Enter the secret value: " VALUE

    SECRET_NAME="${KEY^^}"
    echo "Creating secret '$SECRET_NAME' with value '$VALUE'..."

    gcloud secrets create "$SECRET_NAME" \
      --replication-policy="automatic" \
      --data-file=<(echo -n "$VALUE") \
      --project="$PROJECT_ID"

    gcloud secrets add-iam-policy-binding "$SECRET_NAME" \
      --member="serviceAccount:$PROJECT_ID@cloudbuild.gserviceaccount.com" \
      --role="roles/secretmanager.secretAccessor"

    read -p "Do you want to create another secret? (y/n): " CONTINUE
    if [[ "$CONTINUE" != "y" ]]; then
      break
    fi
  done
fi

echo "Secrets creation completed!"
