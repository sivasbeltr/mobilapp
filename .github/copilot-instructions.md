# Copilot Instructions for Sivas Municipality Mobile Application

This document provides detailed guidelines for developing the Sivas Municipality mobile application, ensuring consistency, maintainability, and scalability. The application mirrors the services available on the Sivas Municipality website (https://www.sivas.bel.tr) and adheres to modern development practices.

---

## General Requirements

1. **Platforms**:
   - The application will support both **Android** and **iOS** platforms.

2. **Language**:
   - UI language: **Turkish**.
   - Codebase and documentation language: **English**.

3. **Design**:
   - The design will be modern, elegant, and user-friendly.
   - It will align with the primary colors of the Sivas Municipality website but may incorporate additional colors for enhanced aesthetics.

4. **Font**:
   - Use **Roboto** as the default font with necessary configurations for consistency across platforms.

5. **Documentation**:
   - Every method and class must include detailed code documentation in English.

6. **Dependencies**:
   - The `pubspec.yaml` file must not be modified directly by automation tools.
   - Required packages and configurations will be specified and applied manually.

---

## Project Structure

1. **Pages**:
   - All pages will be stored under the `/pages` directory.
   - Each page will have its own state management file in the same directory.
     - Example: `/pages/emergency/emergency_page.dart`, `/pages/emergency/emergency_page_state.dart`.
   - Pages will be broken down into their smallest components, stored in a `widgets` subdirectory.
     - Example: `/pages/emergency/widgets/emergency_page_header.dart`.
   - Detail pages will be stored in a `detail` subdirectory with the same structure for state and widgets.
     - Example: `/pages/emergency/detail/earth_quake/earth_quake_page.dart`, `/pages/emergency/detail/earth_quake/widgets`.

2. **Services**:
   - Global HTTP services will be stored under `/client/services`.
   - Page-specific services will be stored in a `services` subdirectory within the respective page directory.
     - Example: `/pages/send_check/services/send_check_service.dart`
   - Services that don't rely on HTTP communication should be placed in the page's own services directory.
   - Each service should have a clear, focused responsibility (e.g., rate limiting, data transformation).

3. **Models**:
   - All data models will be stored under `/client/models`.
   - Model names will follow a clear naming convention.
     - Example: `news_model.dart` → `NewsModel`, `news_detail_model.dart` → `NewsDetailModel`.

4. **Constants**:
   - API endpoints will be defined in `/client/constants/api_endpoints.dart`.
   - Core endpoints will be stored here, though some full URLs may come directly from the API.

5. **Theme**:
   - Theme files will be stored under `/core/theme` to ensure cross-platform consistency.
   - Support both **light** and **dark** modes with full compatibility.

---

## Networking

1. **HTTP Client**:
   - Use **Dio** as the HTTP client.
   - Implement a generic service class to handle all API requests.
     - All pages will derive their clients from this base class.
   - The client must handle both relative endpoints (e.g., `/haberler`) and full URLs (e.g., `https://www.sivas.bel.tr/api/haberler/denemehaber`).
     - Dynamically prepend the domain if needed based on the endpoint type.
   - Ensure resilience against SSL errors:
     - Bypass certificate errors as needed.
     - Configure `HttpOverrides.global` for SSL handling.

2. **Base API URL**:
   - All API requests will use the base URL: `https://www.sivas.bel.tr/api`.

3. **Image Loading**:
   - Use **CachedNetworkImage** for efficient and cached image loading.

4. **Rate Limiting**:
   - Implement rate limiting for user submissions where appropriate.
   - For example, the SendCheckPage implements a 10-minute limit between submissions.
   - Use SharedPreferences to store timestamps for rate-limited actions.

---

## Navigation and Flow

1. **Initial Flow**:
   - The app starts with a **splash screen**.
   - Check for internet connectivity:
     - If offline, navigate to `offline_home_page`.
     - If online, navigate to `home_page`.
   - After `home_page` is loaded, handle any further navigation (e.g., from notifications or deeplinks).

2. **Notifications and Deeplinks**:
   - Implement preprocessing for navigation using `NotificationMessage.init()` to read notifications or deeplink parameters.
   - Supported notification types: news, events, announcements, tenders, etc.
   - On notification click:
     - Navigate to the relevant page.
     - Ensure the back button returns to `home_page`.
   - If no notification or deeplink is present, open `home_page`.
   - Notification handling (Firebase or local) will be configured at the end of the project.

---

## UI Components

1. **App Bars**:
   - Use the custom `PagesAppBar` component for all pages except special cases.
   - `PagesAppBar` provides consistent styling with customization options.
   - Do not derive pages from a base page class; instead, use the appropriate app bar component.

---

## Logging

1. **Logger**:
   - Implement a system-wide **Logger** for debug logging.
   - Ensure logs are detailed and useful for debugging purposes.

---

## Development Guidelines

1. **Code Quality**:
   - Break down UI components into reusable, small widgets.
   - Maintain a clean and modular codebase.
   - Follow consistent naming conventions.
   - Never use withOpacity use withAlpha

2. **State Management**:
   - Each page will have its own state management logic in a dedicated file.
   - Ensure state files are colocated with their respective pages.

3. **Error Handling**:
   - The HTTP client must handle errors gracefully, especially SSL-related issues.
   - Offline scenarios must be supported with an appropriate UI (`offline_home_page`).

4. **Extensibility**:
   - Design the codebase to accommodate future changes, such as additional pages or API endpoints.
   - Use generic services and modular components to simplify maintenance.

---

## Key Notes

- Ensure the application mirrors all services available on the Sivas Municipality website.
- Prioritize user experience with a modern and intuitive interface.
- Plan for notification and deeplink integration early, even though their setup will occur later.
- Maintain strict adherence to the specified folder structure and naming conventions.

---

This document serves as a blueprint for the Sivas Municipality mobile application. Follow these instructions to ensure a robust, scalable, and maintainable codebase.

