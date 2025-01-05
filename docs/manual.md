![img](../assets/logo.png)
CloudFlow Setup Manual
======================

Introduction
------------

CloudFlow is a set of shell scripts designed to automate the creation and configuration of various Google Cloud services like Secrets Manager, Cloud Build, and CI/CD pipelines. The goal is to make your cloud project setup process quick and easy, reducing manual work and improving consistency.

Prerequisites
-------------

Before using CloudFlow, ensure you have the following:

*   **Google Cloud Account**: You must have an active [Google Cloud account](https://cloud.google.com/).
*   **Google Cloud SDK (gcloud CLI)**: Install the [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) to interact with GCP.
*   **Docker**: Required for building and pushing images. Learn more on the [Docker Docs](https://docs.docker.com/get-docker/).
*   **Git**: To clone the repository. Install from [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).
*   **Bash shell**: Used to run the setup scripts (usually pre-installed on Linux/Mac systems).

Installation
------------

1.  Clone the repository:
    
        git clone https://github.com/dev-ashishk/cloudFlow.git
        cd cloudFlow
    
2.  Make the scripts executable:
    
        chmod +x ./scripts/*.sh
    

Configuration
-------------

Before running the setup script, you might need to configure your environment:

    export PROJECT_ID=your-project-id

For more on configuring your environment in GCP, check out the [authentication setup](https://cloud.google.com/docs/authentication/getting-started) in Google Cloud.

Usage Instructions
------------------

1.  **Run the setup script**:
    
        ./setup.sh
    
2.  **Answer the prompts**: The script will guide you through a series of interactive prompts for creating secrets, enabling APIs, and setting up triggers.
3.  **Create secrets using a .env file**: If you want to create secrets using a .env file, provide the path to the file:
    
        ./create-secrets.sh ./config/.env production
    

Scripts Breakdown
-----------------

*   **setup.sh**: The main script to set up your GCP project.
*   **create-secrets.sh**: Creates secrets based on a .env file or manually. Learn more on managing secrets in Google Cloud [here](https://cloud.google.com/secret-manager).
*   **create-trigger.sh**: Sets up Cloud Build triggers for CI/CD. For more on Cloud Build, check the [official docs](https://cloud.google.com/build).

Troubleshooting
---------------

### Common Issues

*   **Permission Denied**: Make sure you have the appropriate [IAM roles](https://cloud.google.com/iam/docs/understanding-roles) for your project.
*   **API Errors**: Enable necessary APIs in your Google Cloud project. You can enable them through the [Google Cloud Console API Library](https://console.cloud.google.com/apis/library).

FAQs
----

*   **What if I don’t want to use Docker?** You can skip the Docker-related parts in the setup script if you don't need them. Check out Docker alternatives [here](https://cloud.google.com/run).
*   **Can I use this in other regions?** Yes, the scripts can be configured for other Google Cloud regions. Learn about regions [here](https://cloud.google.com/about/locations).

Contributing
------------

If you would like to contribute, feel free to fork the repo and create a pull request! Find contributing guidelines [here](https://opensource.google/docs/starting/).

License
-------

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.