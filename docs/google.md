# Gmail and Drive API Connectors
This project provides Python connectors to interact easily with Google Gmail and Google Drive APIs using the Google API Python client. It handles OAuth2 authentication, API calls, and common file operations.

Table of Contents
Prerequisites

## Google Cloud Project Setup

Gmail API Connector

Drive API Connector

Sample Usage

Troubleshooting

License

Prerequisites
Python 3.7+

Google API Python Client and dependencies (install via requirements.txt or manually):

bash
pip install google-api-python-client google-auth google-auth-oauthlib google-auth-httplib2 pandas
A Google Cloud Console project with OAuth credentials created and APIs enabled.

Google Cloud Project Setup
Go to Google Developers Console.

Create/select your project.

Navigate to APIs & Services → Credentials.

Create OAuth 2.0 Client ID credentials:

Choose Desktop app or Web application (recommended for local development).

For a web application, add the following URLs to Authorized redirect URIs:

text
http://localhost:8080/
https://localhost:8080/
http://localhost:8080/oauth2callback
https://localhost:8080/oauth2callback
http://127.0.0.1:5000/callback
https://127.0.0.1:5000/callback
Download the generated credentials.json file and place it under your test/google/ folder (or update path accordingly).

Enable APIs for your project:

Visit Google Drive API and enable it.

Visit Gmail API and enable it.

If your app hasn’t been verified by Google, add test users under OAuth consent screen settings to allow access.

Gmail API Connector
The Gmail connector provides OAuth authentication and wrappers around Gmail API calls such as listing labels, retrieving messages, and downloading attachments.

Key Features
Authenticate user via OAuth 2.0 flow.

List Gmail labels and messages.

Read detailed message contents including attachments.

Download and save attachments locally.

Support for incremental token storage (token.pickle).

Drive API Connector
The Drive connector supports Google Drive interactions including:

Authentication via OAuth 2.0.

Getting user profile and storage quota info.

Listing files and folders with tree visualization.

Uploading single & multiple files and folders recursively.

Downloading files and multiple files to specified directories.

Sample Usage
Below are basic examples to get started with Gmail and Drive connectors.

Gmail API Example
python
from pyconnector.pygoogle.gmail_connector import GmailConnector
import json
import os

def gmail(creds_path):
    print("Using Gmail API with credentials from:", creds_path)
    gmail_client = GmailConnector(creds_file=creds_path, token_file='token.pickle')
    labels = gmail_client.list_labels()
    print("Gmail Labels:", json.dumps(labels, indent=2))

if __name__ == "__main__":
    root_path = os.getcwd()
    creds_path = os.path.join(root_path, 'test', 'google', 'credentials.json')
    gmail(creds_path)
Drive API Example
python
from pyconnector.pygoogle.drive_connector import DriveConnector
import os

def drive_demo(creds_path):
    drive_client = DriveConnector(creds_file=creds_path, token_file='token_drive.pickle')
    
    # Get profile info
    profile = drive_client.get_profile()
    print("Drive User Profile:", profile)

    # List files in root folder
    files = drive_client.list_files(page_size=5)
    print("Files:", files)

    # Upload a file
    file_id = drive_client.upload_file('example.pdf', 'application/pdf')
    print(f"Uploaded file with ID: {file_id}")

if __name__ == "__main__":
    root_path = os.getcwd()
    creds_path = os.path.join(root_path, 'test', 'google', 'credentials.json')
    drive_demo(creds_path)
User Manual
Running your scripts
Activate your virtual environment:

bash
source pycon/bin/activate
Set the PYTHONPATH environment variable to your project root if needed:

bash
export PYTHONPATH=$(pwd)
Run the test scripts either as modules or directly:

bash
python -m test.google   # For Gmail tests
python -m test.drive    # For Drive tests, if you have scripts for it
Handling OAuth Consent Errors
If you get an error about the app not being verified, add your Google account to Test users in the OAuth Consent Screen settings.

Be sure the redirect URI you configured matches exactly the URLs used by the app.