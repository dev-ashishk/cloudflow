# This script sets up various components for a GCP project.
# It prompts the user to enter the GCP project ID and region, then presents a menu of options to perform different setup tasks.
#
# Options:
# 1. Enable APIs - Runs the enable-apis.sh script to enable necessary APIs for the project.
# 2. Create Secrets - Runs the create-secrets.sh script to create secrets in the project.
# 3. Create Artifact Registry - Runs the create-artifacts-repo.sh script to create an artifact registry in the specified region.
# 4. Create Build Trigger - Runs the create-trigger.sh script to create a build trigger for the project.
# 5. Check IAM Roles - Runs the check-roles.sh script to check IAM roles for the project.
# 6. All the above - Runs all the above tasks sequentially.
# 7. Exit - Exits the setup script.
#
# Usage:
# 1. Run the script: ./setup.sh
# 2. Follow the prompts to enter the GCP project ID and region.
# 3. Choose an option from the menu to perform the desired setup task.
#!/bin/bash

echo "------------ Welcome to the GCP Setup ----------------"

read -p "Enter GCP project ID: " PROJECT_ID
read -p "Enter region (e.g., us-central1): " REGION

echo "Choose an option:"
echo "1. Enable APIs"
echo "2. Create Secrets"
echo "3. Create Artifact Registry"
echo "4. Create Build Trigger"
echo "5. Check IAM Roles"
echo "6. All the above"
echo "7. Exit"

read -p "Enter your choice: " choice


case $choice in
  1)
    ./scripts/enable-apis.sh "$PROJECT_ID"
    ;;
  2)
    ./scripts/create-secrets.sh "$PROJECT_ID"
    ;;
  3)
    ./scripts/create-artifacts-repo.sh "$PROJECT_ID" "$REGION"
    ;;
  4)
    ./scripts/create-trigger.sh "$PROJECT_ID"
    ;;
  5)
    ./scripts/check-roles.sh "$PROJECT_ID"
    ;;
  6)
    # Run all tasks with the common information
    ./scripts/enable-apis.sh "$PROJECT_ID"
    ./scripts/create-secrets.sh "$PROJECT_ID"
    ./scripts/create-artifacts-repo.sh "$PROJECT_ID" "$REGION"
    ./scripts/create-trigger.sh "$PROJECT_ID"
    ./scripts/check-roles.sh "$PROJECT_ID"
    ;;
  7)
    echo "Exiting setup."
    exit 0
    ;;
  *)
    echo "Invalid choice. Please try again."
    ;;
esac
