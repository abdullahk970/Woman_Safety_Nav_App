🛡️ Women Safety Navigation App

A Flutter-based Women Safety Navigation App designed to help users quickly locate nearby safe places and navigate to them in emergency situations. The application integrates GPS location tracking, Google Maps, live distance calculation, and emergency navigation to provide real-time safety assistance.

The app follows a clean architecture with Provider state management, ensuring scalability, maintainability, and a professional project structure.

🚀 Features
🔐 Authentication & Onboarding

Splash Screen

Login Screen

Secure navigation flow

🏠 Home Dashboard

Quick access to safety features

User-friendly interface

Modern UI design

📍 Nearby Safe Places

Displays nearby:

Police Stations

Hospitals

Help Centers

Data loaded from local JSON files

🗺️ Google Maps Integration

Interactive map showing safe place markers

Current user location displayed

Tap markers to view location details

📏 Live Distance Calculation

Calculates real-time distance between user and safe locations

Automatically sorts nearest locations first

🔎 Filtering System

Users can filter locations by:

All

Police Stations

Hospitals

Help Centers

🚨 Emergency Navigation

One-tap navigation to the nearest safe place

Opens Google Maps with turn-by-turn directions

👤 Profile & Settings

User profile section

Basic app settings

🛠️ Tech Stack

Flutter (Dart)

Provider – State Management

Google Maps Flutter

Geolocator – GPS & Location Services

JSON – Local Data Storage

URL Launcher – Navigation to Google Maps

📂 Project Structure
lib
│
├── core
│   ├── services
│   │   └── location_service.dart
│   └── utils
│       ├── json_loader.dart
│       └── directions_launcher.dart
│
├── models
│   └── safe_place_model.dart
│
├── providers
│   ├── auth_provider.dart
│   ├── location_provider.dart
│   ├── safe_places_provider.dart
│   └── profile_provider.dart
│
├── views
│   ├── splash
│   ├── auth
│   ├── home
│   ├── safe_places
│   ├── maps
│   ├── emergency
│   └── profile
│
└── main.dart
📦 Installation
1️⃣ Clone the Repository
git clone https://github.com/yourusername/women-safety-navigation-app.git
2️⃣ Navigate to Project
cd women-safety-navigation-app
3️⃣ Install Dependencies
flutter pub get
4️⃣ Run the App
flutter run
🔑 Google Maps Setup

To enable Google Maps:

Android

Add your API key in:

android/app/src/main/AndroidManifest.xml
<meta-data
android:name="com.google.android.geo.API_KEY"
android:value="YOUR_GOOGLE_MAPS_API_KEY"/>
📊 Data Source

The application uses local JSON files to load safe place data.

Example structure:

assets/json/safe_places.json

Example entry:

{
  "name": "Central Police Station",
  "type": "Police",
  "latitude": 24.8607,
  "longitude": 67.0011,
  "address": "City Center"
}
🎯 Key Highlights

Clean architecture

Provider-based state management

Real-time GPS integration

Google Maps marker visualization

Live distance calculations

Emergency navigation system

Scalable project structure

📌 Future Improvements

Dark Mode Support

Real-time backend integration

Push notifications for emergency alerts

AI-powered safe route suggestions

User contact emergency alerts

👨‍💻 Author

Abdullah Khan

Computer Science Student | Flutter Developer
