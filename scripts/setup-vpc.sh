#!/bin/bash

PROJECT_ID=$1

if [[ -z "$PROJECT_ID" ]]; then
  echo "Usage: $0 <PROJECT_ID>"
  exit 1
fi

read -p "Enter the name for the VPC network: " VPC_NAME
read -p "Enter the region for the subnet: " REGION
read -p "Enter the range for the subnet (e.g., 10.0.0.0/24): " SUBNET_RANGE
read -p "Enter the name for the subnet: " SUBNET_NAME
read -p "Enter the name for the firewall rule: " FIREWALL_NAME
read -p "Enter the source IP range for the firewall rule (e.g., 0.0.0.0/0): " SOURCE_RANGE
read -p "Enter the service account email for permissions: " SERVICE_ACCOUNT_EMAIL

echo "Creating VPC network '$VPC_NAME'..."
gcloud compute networks create "$VPC_NAME" \
  --subnet-mode=custom \
  --project="$PROJECT_ID"

echo "Creating subnet '$SUBNET_NAME' in region '$REGION'..."
gcloud compute networks subnets create "$SUBNET_NAME" \
  --network="$VPC_NAME" \
  --range="$SUBNET_RANGE" \
  --region="$REGION" \
  --project="$PROJECT_ID"

echo "Creating firewall rule '$FIREWALL_NAME'..."
gcloud compute firewall-rules create "$FIREWALL_NAME" \
  --network="$VPC_NAME" \
  --allow=tcp,udp,icmp \
  --source-ranges="$SOURCE_RANGE" \
  --project="$PROJECT_ID"

echo "Assigning IAM roles to service account '$SERVICE_ACCOUNT_EMAIL'..."
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/compute.networkAdmin"

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/iam.serviceAccountUser"

echo "VPC and subnet setup completed successfully!"
echo "Details:"
echo "  VPC Network: $VPC_NAME"
echo "  Subnet: $SUBNET_NAME (Region: $REGION, Range: $SUBNET_RANGE)"
echo "  Firewall Rule: $FIREWALL_NAME (Source Range: $SOURCE_RANGE)"
echo "  Service Account: $SERVICE_ACCOUNT_EMAIL"

read -p "Do you want to verify the configuration? (y/n): " VERIFY
if [[ "$VERIFY" == "y" ]]; then
  echo "Fetching VPC details..."
  gcloud compute networks describe "$VPC_NAME" --project="$PROJECT_ID"

  echo "Fetching subnet details..."
  gcloud compute networks subnets describe "$SUBNET_NAME" --region="$REGION" --project="$PROJECT_ID"

  echo "Fetching firewall rule details..."
  gcloud compute firewall-rules describe "$FIREWALL_NAME" --project="$PROJECT_ID"
fi
