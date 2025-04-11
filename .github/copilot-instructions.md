# Sivas Municipality Mobile Application Development Guidelines

## General Rules
- Development language and code comments: English
- UI language: Turkish
- Follow a modular architecture with "divide and conquer" approach
- Break down all components into the smallest manageable parts

## Project Structure
```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── client/
│   ├── models/
│   └── services/
├── pages/
└── widgets/
```

## Architecture & Design Patterns
1. **Theme Configuration**
   - Complete and consistent theme configuration from the start
   - Use Google's Roboto font family for cross-platform consistency
   - Support for light and dark themes

2. **State Management**
   - Use Provider as the state management solution
   - Keep state logic separate from UI

3. **Network & API**
   - Use Dio as HTTP client
   - Create a base client class for all API operations
   - Implement proper error handling and retry logic
   - Separate models and services by endpoint/page

4. **Navigation**
   - Implement deep linking support from the beginning
   - Prepare notification handling for Firebase Cloud Messaging (FCM)
   - Use named routes for easy deep link handling

5. **Base Pages**
   - Create a BasePage class that all pages will extend
   - Include offline/online accessibility property
   - Implement page parameter handling for deep links and notifications

6. **File Organization**
   - Models: `client/models/[model_name].dart`
   - Services: `client/services/[page]_service.dart`
   - Pages: `pages/[page_name]/[page_name]_page.dart`
   - Page Widgets: `widgets/[page_name]/[widget_name].dart`

7. **Application Flow**
   - Start with a splash screen
   - Check connectivity and direct to online or offline home page
   - Implement proper caching for offline functionality

8. **Dependency Management**
   - Manual updates to pubspec.yaml only
   - Document all dependencies and their purpose

## Coding Standards
1. Use meaningful variable and function names
2. Keep functions small and focused on a single task
3. Document all public classes and functions
4. Follow Dart style guide and formatting rules
5. Use constants for all hardcoded values
6. Implement proper error handling throughout the app
7. Use assertions for debugging
8. Write unit tests for business logic

## Future Considerations
1. FCM for notifications will be implemented later
2. Optimize for different screen sizes
3. Implement proper data caching for offline mode
4. Consider accessibility features