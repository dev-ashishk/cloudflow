#!/bin/bash

PROJECT_ID=$1

if [[ -z "$PROJECT_ID" ]]; then
  echo "Usage: $0 <PROJECT_ID>"
  exit 1
fi

# Step 1: Enabling required GCP APIs
echo "Enabling required Google Cloud APIs..."
gcloud services enable container.googleapis.com \
  cloudbuild.googleapis.com \
  artifactregistry.googleapis.com \
  --project="$PROJECT_ID"

# Step 2: Creating a GKE cluster
read -p "Enter the name of the GKE cluster: " CLUSTER_NAME
read -p "Enter the region for the GKE cluster: " REGION
read -p "Enter the number of nodes for the cluster: " NUM_NODES
read -p "Enter the machine type for the nodes (e.g., e2-standard-4): " MACHINE_TYPE

echo "Creating GKE cluster '$CLUSTER_NAME'..."
gcloud container clusters create "$CLUSTER_NAME" \
  --region="$REGION" \
  --num-nodes="$NUM_NODES" \
  --machine-type="$MACHINE_TYPE" \
  --enable-ip-alias \
  --project="$PROJECT_ID"

# Step 3: Geting cluster credentials
echo "Fetching cluster credentials..."
gcloud container clusters get-credentials "$CLUSTER_NAME" --region "$REGION" --project "$PROJECT_ID"

# Step 4: Setting up Artifact Registry for container images
read -p "Enter the name of the Artifact Registry repository: " REPO_NAME
read -p "Enter the region for the Artifact Registry: " REPO_REGION

echo "Creating Artifact Registry repository '$REPO_NAME'..."
gcloud artifacts repositories create "$REPO_NAME" \
  --repository-format=docker \
  --location="$REPO_REGION" \
  --description="Docker repository for microservices" \
  --project="$PROJECT_ID"

# Step 5: Assigning IAM roles for Kubernetes and Artifact Registry
echo "Assigning IAM roles..."
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$PROJECT_ID@cloudbuild.gserviceaccount.com" \
  --role="roles/container.developer"

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$PROJECT_ID@cloudbuild.gserviceaccount.com" \
  --role="roles/artifactregistry.writer"

# Step 6: Creating Kubernetes namespaces
read -p "Enter the namespace for your microservices: " NAMESPACE
kubectl create namespace "$NAMESPACE"
echo "Namespace '$NAMESPACE' created."

# Step 7: Deploying ingress controller (optional)
read -p "Do you want to deploy an ingress controller? (y/n): " DEPLOY_INGRESS
if [[ "$DEPLOY_INGRESS" == "y" ]]; then
  echo "Deploying ingress-nginx controller..."
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
fi

# Step 8: Creating secret for Docker registry access
read -p "Enter the Docker registry username: " DOCKER_USERNAME
read -p "Enter the Docker registry password: " DOCKER_PASSWORD
read -p "Enter the Docker registry server (e.g., gcr.io): " DOCKER_SERVER

kubectl create secret docker-registry regcred \
  --docker-username="$DOCKER_USERNAME" \
  --docker-password="$DOCKER_PASSWORD" \
  --docker-server="$DOCKER_SERVER" \
  --namespace="$NAMESPACE"
echo "Docker registry credentials stored as a Kubernetes secret."

# Step 9: Deploying a sample microservice
read -p "Do you want to deploy a sample microservice? (y/n): " DEPLOY_SAMPLE
if [[ "$DEPLOY_SAMPLE" == "y" ]]; then
  echo "Deploying sample microservice..."
  cat <<EOF | kubectl apply -n "$NAMESPACE" -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample-service
spec:
  replicas: 2
  selector:
    matchLabels:
      app: sample-service
  template:
    metadata:
      labels:
        app: sample-service
    spec:
      containers:
      - name: sample-service
        image: ${REPO_REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/sample-service:latest
        ports:
        - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: sample-service
spec:
  selector:
    app: sample-service
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  type: LoadBalancer
EOF
fi

echo "Kubernetes environment setup completed!"
echo "Details:"
echo "  GKE Cluster: $CLUSTER_NAME"
echo "  Namespace: $NAMESPACE"
echo "  Artifact Registry: $REPO_NAME"
echo "  Region: $REGION"

# Step 10: Verify cluster and deployment
read -p "Do you want to verify the setup? (y/n): " VERIFY
if [[ "$VERIFY" == "y" ]]; then
  echo "Fetching cluster details..."
  gcloud container clusters describe "$CLUSTER_NAME" --region "$REGION" --project "$PROJECT_ID"

  echo "Fetching deployed services..."
  kubectl get all -n "$NAMESPACE"
fi
