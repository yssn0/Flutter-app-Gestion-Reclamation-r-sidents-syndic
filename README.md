# Gestion Reclamation résidents-syndic

A Flutter-based mobile application for managing resident-syndic reclamations efficiently.

## Overview

This application streamlines the process of submitting and managing reclamations between residents and syndics. It provides a user-friendly interface for residents to submit issues and for syndics to manage and respond to these reclamations effectively.

## Features

### For Residents:
- Submit new reclamations with detailed descriptions and photo attachments
- Track the status of submitted reclamations in real-time
- Receive notifications on reclamation updates

### For Syndics:
- View and manage all submitted reclamations in one place
- Respond to reclamations and update their status
- Prioritize and categorize reclamations for efficient handling

## Getting Started

### Prerequisites

* Flutter (version 2.x or later)
* Android Studio or Visual Studio Code with Flutter plugin
* iOS development environment (for iOS builds)
* MongoDB Atlas account
* Firebase account

### Installation for Developers

1. Clone the repository: `git clone https://github.com/yssn0/Flutter-app-Gestion-Reclamation-residents-syndic.git`
2. Navigate to the project directory: `cd Flutter-app-Gestion-Reclamation-r-sidents-syndic`
3. Install dependencies: `flutter pub get`
4. Run the application: `flutter run`

## Important Notes

### MongoDB Atlas and Firebase Configuration

The files `MongoDB Atlas`, `firebase_options.dart`, `Databasefirebase.json`, `atlasonfig.json`, and `google-services.json` contain sensitive information such as keys and app IDs. For security reasons, the values of these files have been changed.

To use this project, you must create your own MongoDB Atlas database and Firebase project, and replace the variables with your own keys and IDs.

### Creating a MongoDB Atlas Database

1. Go to the [MongoDB Atlas website](https://www.mongodb.com/cloud/atlas) and create an account.
2. Create a new cluster and database.
3. Create a new user and obtain the connection string.
4. Replace the `MongoDB Atlas` file with your own connection string.

### Creating a Firebase Project

1. Go to the [Firebase website](https://firebase.google.com/) and create an account.
2. Create a new Firebase project.
3. Enable the necessary services (e.g. Authentication, Realtime Database).
4. Obtain the Firebase configuration file (`google-services.json`) and replace the existing file.
5. Replace the `firebase_options.dart` file with your own Firebase options.

### Replacing Variables

Replace the following variables with your own keys and IDs:

* `appId` in `firebase_options.dart`
* `apiKey` in `firebase_options.dart`
* `databaseURL` in `Databasefirebase.json`
* `connectionString` in `MongoDB Atlas`

## Usage

### Test Accounts

For those who want to try the app without creating a new account, you can use the following test credentials:

#### Resident Account:
- Email: test@gmail.com
- Password: test123

#### Syndic Account:
- Email: test@syndic.com
- Password: test123


## Installation Instructions for Users

1. **Enable Installation from Unknown Sources**:
   - Open your device's **Settings**.
   - Navigate to **Security** or **Apps & Notifications**.
   - Tap on **Install unknown apps**.
   - Select the app (e.g., Chrome or your file manager) that you'll use to download the APK.
   - Toggle on **Allow from this source**.

2. **Download and Install the APK**:
   - Click on the [APK download link](https://github.com/yssn0/Flutter-app-Gestion-Reclamation-residents-syndic/releases) to download the file.
   - Once downloaded, open the APK file.
   - Follow the on-screen prompts to install the application.

## How to Use

1. **Login**: Use the provided test accounts
2. **Submit a Reclamation** (Resident):
   - Tap on "New Reclamation"
   - Fill in the description
   - Add photos if necessary
   - Submit the reclamation
3. **Manage Reclamations** (Syndic):
   - View all reclamations
   - Tap on a reclamation to view details
   - Update status or respond to the reclamation




