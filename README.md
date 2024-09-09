# Flutter Music Player App

Flutter Music Player App is a simple and elegant music player application built using the Flutter framework. The app allows users to play local music files with a smooth and intuitive interface. It includes features like dark mode, persistent settings, and responsive UI transitions.

## Features

- 🎵 Play local audio files with smooth playback.
- 🌙 Dark mode and light mode transitions.
- ⚡ State management with [GetX](https://pub.dev/packages/get).
- 💾 Persistent settings storage using [Shared Preferences](https://pub.dev/packages/shared_preferences).
- 🎧 Support for multiple audio formats with [Audio Players](https://pub.dev/packages/audioplayers).
- 📱 Responsive and adaptive UI design.

## Packages Used

- **GetX**: A powerful state management, dependency injection, and route management solution for Flutter apps. 
- **Shared Preferences**: A simple key-value storage for saving user preferences (like theme selection) persistently.
- **Audio Players**: A Flutter plugin that enables audio playback for local and network-based audio files.

## Screenshots

### Light Mode

| ![Light Mode 1](https://github.com/user-attachments/assets/21ead27f-9c96-4667-b41f-d2d6ddcb7a75)  | ![Light Mode 2](https://github.com/user-attachments/assets/266e82a5-2026-4f6a-b9f1-3945d5e0b121) |
|:--:|:--:|

### Dark Mode

| ![Dark Mode 1](https://github.com/user-attachments/assets/17c214e6-644c-49ef-bf1e-444f77634c97)  | ![Dark Mode 2](https://github.com/user-attachments/assets/35cc4675-e321-4551-b42c-a75e56336480) | ![Dark Mode 3](https://github.com/user-attachments/assets/90a031b8-5d5c-4f18-b8f8-3419ce72bec0) |
|:--:|:--:|:--:|

### Folder Structure

```bash
lib/
│
├── controllers/         # GetX controllers for managing state
├── models/              # Data models related to the music player
├── views/               # UI screens for the music player
├── services/            # Audio service and storage handling
└── main.dart            # App entry point

