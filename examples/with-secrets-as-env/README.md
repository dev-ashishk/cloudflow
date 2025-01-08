![img](../../assets/logo-black.png)

Cloud Build Pipeline for Docker, Cloud Run, and Secrets Management
==================================================================

This configuration file is designed to automate the process of building a Docker image, pushing it to Google Artifact Registry, deploying it to Google Cloud Run, and securely injecting secrets into the runtime environment.

Overview
--------

The pipeline performs the following tasks:

1.  **Build a Docker Image:** Builds a Docker image from the specified Dockerfile.
2.  **Push to Artifact Registry:** Pushes the built Docker image to Google Artifact Registry.
3.  **Deploy to Cloud Run:** Deploys the Docker image to Google Cloud Run and injects secrets as environment variables at runtime.

Configuration Details
---------------------

### Steps

1.  #### Docker Build
    
    This step builds the Docker image using the [Cloud Build Docker builder](https://cloud.google.com/cloud-build/docs/building/build-containers) and tags it with the appropriate name and version.
    
        
        - name: 'gcr.io/cloud-builders/docker'
          args:
            - 'build'
            - '-t'
            - '${_REGION}-docker.pkg.dev/${PROJECT_ID}/${_REPOSITORY_NAME}/${_IMAGE_NAME}:$SHORT_SHA'
            - '-f'
            - '${_DOCKERFILE_RELATIVE_PATH}'
            - '.'
              
    
2.  #### Push Docker Image
    
    This step pushes the built Docker image to [Google Artifact Registry](https://cloud.google.com/artifact-registry/docs) for storage and deployment.
    
        
        - name: 'gcr.io/cloud-builders/docker'
          args:
            - 'push'
            - '${_REGION}-docker.pkg.dev/${PROJECT_ID}/${_REPOSITORY_NAME}/${_IMAGE_NAME}:$SHORT_SHA'
              
    
3.  #### Deploy to Cloud Run with Secrets
    
    This step deploys the Docker image to [Google Cloud Run](https://cloud.google.com/run/docs). It also securely injects secrets into the runtime environment using [Google Secret Manager](https://cloud.google.com/secret-manager).
    
        
        - name: 'gcr.io/cloud-builders/gcloud'
          args:
            - 'run'
            - 'deploy'
            - '${_SERVICE_NAME}'
            - '--image=${_REGION}-docker.pkg.dev/${PROJECT_ID}/${_REPOSITORY_NAME}/${_IMAGE_NAME}:${SHORT_SHA}'
            - '--region=${_REGION}'
            - '--platform=managed'
            - '--labels=${_LABELS}'
            - '--set-secrets=MONGODB_URI=MONGODB_URI:latest'
            - '--set-secrets=NODE_ENV=NODE_ENV:latest'
            - '--set-secrets=WEBHOOK_SECRET=WEBHOOK_SECRET:latest'
              
    
    For more details, refer to the [Cloud Run Secrets documentation](https://cloud.google.com/run/docs/securing/secrets).
    

### Timeout

The build process has a timeout of **1500 seconds (25 minutes)**.

### Substitutions

The following substitution variables can be customized:

    
    _IMAGE_NAME: '[Enter here Image Name]'
    _REPOSITORY_NAME: '[Enter here Repository Name]'
    _DOCKERFILE_RELATIVE_PATH: './deployment/Dockerfile'
    _SERVICE_NAME: '[Enter here service name]'
    _LABELS: 'env=production'
    _REGION: 'us-central1'
      

For more information on substitutions, refer to the [Cloud Build Substitution Variables documentation](https://cloud.google.com/cloud-build/docs/configuring-builds/substitute-variable-values).

### Options

Only Cloud Logging is enabled for logging:

    
    options:
      logging: CLOUD_LOGGING_ONLY
      

Learn more about logging options in the [Cloud Build Logging documentation](https://cloud.google.com/cloud-build/docs/configuring-builds/logging).

Getting Started
---------------

Follow these steps to use the pipeline:

1.  Ensure the [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) is installed and authenticated.
2.  Replace placeholders in the `substitutions` section with your specific project details.
3.  Run the build using Cloud Build or configure a trigger in the Google Cloud Console.

Additional Resources
--------------------

*   [Google Cloud Build Documentation](https://cloud.google.com/cloud-build/docs)
*   [Google Artifact Registry Documentation](https://cloud.google.com/artifact-registry/docs)
*   [Google Cloud Run Documentation](https://cloud.google.com/run/docs)
*   [Google Secret Manager Documentation](https://cloud.google.com/secret-manager)