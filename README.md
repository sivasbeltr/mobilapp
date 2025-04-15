# Sivas Belediyesi Mobile Application

A mobile application for Sivas Municipality that provides access to municipality services, news, events, and more.

## Overview

This application is built to mirror the services available on the Sivas Municipality website (https://www.sivas.bel.tr) and provide citizens with easy access to municipal services, news, events, announcements, and other important information.

## Features

- **Home Screen**: Access to all municipal services
- **News**: Latest news from the municipality
- **Events**: Upcoming events in Sivas
- **Services**: Access to various municipal services
- **Offline Mode**: Basic functionality when offline
- **Notifications**: Push notifications for important announcements and events
- **Theme Support**: Light and dark mode support

## Getting Started

### Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio or VS Code with Flutter plugins

### Installation

1. Clone the repository
```
git clone https://github.com/yourusername/sivas_belediyesi.git
```

2. Navigate to the project directory
```
cd sivas_belediyesi
```

3. Get dependencies
```
flutter pub get
```

4. Run the app
```
flutter run
```

## Project Structure

The project follows a modular architecture with the following directory structure:

- `/lib`: Main source code
  - `/client`: API client and network-related code
    - `/constants`: API endpoints and other constants
    - `/models`: Data models
    - `/services`: API services
  - `/core`: Core functionality
    - `/services`: Core services
    - `/theme`: Theme configuration
    - `/utils`: Utility functions
  - `/pages`: UI screens
    - `/{feature}`: Feature-specific screens
      - `/{feature}_page.dart`: Main screen file
      - `/{feature}_page_state.dart`: State management for the screen
      - `/widgets`: Screen-specific widgets
      - `/detail`: Detail screens for the feature

## Dependencies

- **dio**: HTTP client for API requests
- **cached_network_image**: Image caching and loading
- **shared_preferences**: Local storage
- **flutter_svg**: SVG support
- **url_launcher**: For opening URLs, maps, etc.
- **flutter_screenutil**: For responsive UI
- **intl**: For localization

## Development Notes

- The app supports both Android and iOS platforms.
- UI language is Turkish, while codebase and documentation are in English.
- The app uses the Roboto font family for consistent typography.

## License

This project is proprietary and confidential. Unauthorized copying, distributing, or use is prohibited.
