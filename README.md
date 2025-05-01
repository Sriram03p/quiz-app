# Quiz Master App

A Flutter-based quiz application with local/online questions and leaderboard functionality.

## Features
- Multiple question sources (Local & API)
- Leaderboard with SQLite storage
- State management with Provider
- Clean UI with custom widgets
- Comprehensive testing

## Tech Stack
- **Framework**: Flutter
- **State Management**: Provider
- **Local Storage**: sqflite, shared_preferences
- **Networking**: http
- **Testing**: flutter_test

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/sriram03p/quiz-master.git 
Install dependencies:

bash
flutter pub get
Run the app:

bash
flutter run
Project Structure
lib/
├── main.dart
├── models/
├── providers/
├── screens/
├── services/
├── utils/
└── widgets/
Dependencies
yaml
dependencies:
provider: ^6.0.5
http: ^0.13.5
sqflite: ^2.2.0
shared_preferences: ^2.2.0
Team Workflow
UI Developer: Widgets, Navigation, Theming

Logic Developer: State, APIs, Database

Collaboration: Feature branches → Code review → Merge