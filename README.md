![MIT License](https://img.shields.io/badge/License-MIT-green.svg)

CloudFlow - The Ultimate Cloud Setup Companion
![Logo](./logo.svg)
Welcome to CloudFlow 🚀
=======================

Your **ultimate** cloud setup companion for Google Cloud Platform! 🌥️

What is CloudFlow? 🤔
---------------------

CloudFlow is a powerful and **user-friendly script** designed to make your Google Cloud Platform (GCP) setup as smooth as possible. Whether you're a seasoned pro or just starting out, CloudFlow guides you step-by-step with intuitive prompts, **automating tasks** that would otherwise take hours of tedious manual configuration. 🌟

Why Use CloudFlow? 🌈
---------------------

*   **Automation**: CloudFlow handles repetitive tasks for you, reducing the chance of human error. 🧑‍💻
*   **Ease of Use**: With clear, step-by-step prompts, you don't need to be an expert to set up your GCP environment. 💡
*   **Flexibility**: Choose which tasks to run, or run everything in one go! Flexibility at its finest. 🔄
*   **Prevention of Errors**: CloudFlow validates everything before proceeding, ensuring you’re always on the right track. 🔒

How Does It Work? 🛠️
---------------------

Simply follow the prompts to:

*   Set up IAM roles and permissions 👩‍💼
*   Enable necessary APIs ⚡
*   Create and manage secrets 🔑
*   Configure your Cloud Build pipeline 🔄
*   Set up triggers to automate workflows 🔔

The CloudFlow Advantage 🌟
--------------------------

*   **Streamlined Cloud Setup**: Skip the complexity! CloudFlow makes GCP setup a breeze. 💨
*   **Interactive and Friendly**: No need to dive into dense documentation. CloudFlow holds your hand throughout. 🤝
*   **Less Stress, More Focus**: Spend less time configuring, more time developing! 🎉

### Pros 🏆

*   **Efficiency**: Automates tedious tasks like IAM role assignment and API enabling. 🔧
*   **Simple Interface**: No more guesswork. The prompts make everything clear and easy to follow. 🧠
*   **Flexibility**: Pick and choose tasks to run or automate your entire setup with just a single command! 🧳

### Cons ⚠️

*   **Requires Proper IAM Permissions**: You’ll need to have sufficient roles assigned to run certain commands. 🔑
*   **Manual Inputs Needed**: Some tasks, like creating secrets or setting up triggers, require specific information from you. 💬
*   **Cloud SDK Dependency**: The script requires the Google Cloud SDK (gcloud CLI) to work properly. 🌐

### Why CloudFlow is the Best for You 💖

*   **Complete Automation**: Skip the manual work and let CloudFlow do the heavy lifting! 🏋️‍♂️
*   **Super User-Friendly**: No steep learning curve, just simple, interactive prompts. 📲
*   **Consistent, Error-Free Setup**: CloudFlow ensures that all your GCP resources are correctly configured, every time. ✅

The CloudFlow Scripts 📝
------------------------

CloudFlow consists of several essential scripts that make your cloud setup a walk in the park! Here's an overview of each:

*   **setup.sh**: This is the brain of the operation! It prompts you for all the necessary details to configure IAM roles, enable APIs, create secrets, set up Cloud Build, and much more. It's an interactive wizard that makes setting up GCP a breeze. 🎩
*   **create-secrets.sh**: Need secrets? This script allows you to create secrets in Google Cloud Secret Manager by either inputting them manually or passing a .env file. It ensures your sensitive data is stored securely, so you don’t have to worry about a thing. 🔑
*   **create-trigger.sh**: Automate your workflows with ease. This script helps you create triggers that can automatically start a build, deploy, or any other action you want. All you need to do is provide the necessary details and let CloudFlow do the rest. 🔄

How to Use CloudFlow 🚀
-----------------------

Getting started with CloudFlow is super simple! Just follow these steps:

*   Clone the CloudFlow repository to your local machine:

git clone https://github.com/dev-ashishk/cloudflow.git
        

*   Navigate to the project directory:

cd cloudflow
        

*   Make the script files executable:

chmod +x ./scripts/\*.sh
        

*   Run the main setup script:

./setup.sh

License Information 📜
----------------------

CloudFlow is open-source software released under the **MIT License**. Feel free to fork, modify, and distribute it according to your needs. We only ask that you include the same license in any distributions or modifications. By doing so, you help make the cloud setup experience even better for everyone! 🌍

For more details about the license, please refer to the [LICENSE file](LICENSE) in the repository.

Ready to Get Started? 🚀
------------------------

Get started today and automate your GCP setup with CloudFlow! ✨

[Star CloudFlow on GitHub ⭐](https://github.com/dev-ashishk/cloudflow)

Created with ❤️ by [Ashish Kumar](https://www.linkedin.com/in/ashishkumar17/). Open source and ready to help you streamline your GCP setup! 🌟
