# 💸 Nexpense

## Firebase Checklist

```diff
+ [✓] Google Sign In
- [ ] Authenticated Database
- [ ] User Settings
```

# [Android & Web] [Firebase]

## A simple cross-platform Expense-Tracker that uses GSheets API to store and retrieve your expenses in a Google spreadsheet.

## Note

```diff
- The loading time is slow and takes around 15-20 seconds. Please don't do anything while it's loading.
- You can only load the data once per minute. 
- Multiple instances of the same app running together will not load any data and create unhandled errors.
+ It will be fixed in future using cached memory and user authentication.
```

Appname & Author  | Android APK [recommended] | Web App
------------- | ------------- | ------------- 
Nexpense - Akshay Krishna |  [Download APK](https://github.com/edaxe/nexpense/releases/tag/APK) | [Deployed Web App](https://edaxe.github.io) 

## Screenshots

| ![](https://github.com/edaxe/nexpense/blob/main/release/1.png)  | ![](https://github.com/edaxe/nexpense/blob/main/release/2.png) | ![](https://github.com/edaxe/nexpense/blob/main/release/3.png) |
| ------------- | ------------- | ------------- |

## Video Demo

#### https://youtu.be/y2JmsmkK8Pw


## Install instructions

- Clone the project using terminal or download ZIP or just download the APK
``` git clone https://github.com/edaxe/nexpense.git```
- Run Flutter package getter
``` flutter pub get ```
- Run on your preferred platform
``` flutter run ``` or 
``` flutter run -d ```

## Working Features

- Google Spreadsheet API as database [Universal database].
- Add Transaction with important data such as Category/Name/Amount/In or Out.
- View Spending Analysis with a Pie Chart.
- Catorization based on usage with unique icons & colors.

## Upcoming Features

- Firebase Authentication.
- Databases unique to authenticated users.
- Option to modify/delete a transaction.
- Locally cached database.

## Instructions to use your own spreadsheet

- Follow this guide to create your own API keys.
  - https://developers.google.com/sheets
- Add the keys to /lib/google_sheets_api.dart
