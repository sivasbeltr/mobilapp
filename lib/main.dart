import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'client/services/http_client_service.dart';
import 'core/services/notification_message.dart';
import 'core/theme/app_theme.dart';
import 'pages/events/detail/event_detail_page.dart';
import 'pages/news/detail/news_detail_page.dart';
import 'pages/splash/splash_page.dart';

/// The main entry point of the application.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize the HTTP client
  final httpClient = HttpClientService();
  httpClient.init();

  // Load saved theme preference
  final prefs = await SharedPreferences.getInstance();
  final savedThemeMode = prefs.getString('themeMode');
  final initialThemeMode = savedThemeMode != null
      ? ThemeMode.values.firstWhere(
          (mode) => mode.toString() == savedThemeMode,
          orElse: () => ThemeMode.system,
        )
      : ThemeMode.system;

  // Example of deeplink or notification parameters that might come from platform code
  // In a real app, this would be passed from native code via method channels
  // or through Firebase messaging

  // Comment out or modify this section in production
  /*
  final Map<String, dynamic> mockNotificationData = {
    'type': 'event',
    'id': '1',
    'title': 'Sivas Kültür ve Sanat Festivali',
  };
  NotificationMessage.init(data: mockNotificationData);
  */

  runApp(SivasMunicipalityApp(initialThemeMode: initialThemeMode));
}

/// The root widget of the application.
class SivasMunicipalityApp extends StatefulWidget {
  /// The initial theme mode to use.
  final ThemeMode initialThemeMode;

  /// Creates a new [SivasMunicipalityApp].
  const SivasMunicipalityApp({
    super.key,
    this.initialThemeMode = ThemeMode.system,
  });

  @override
  State<SivasMunicipalityApp> createState() => _SivasMunicipalityAppState();
}

class _SivasMunicipalityAppState extends State<SivasMunicipalityApp>
    with WidgetsBindingObserver {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    // Only update if we're in system mode
    if (_themeMode == ThemeMode.system) {
      setState(() {
        // This triggers a rebuild with the new system brightness
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sivas Belediyesi',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      home: const SplashPage(),
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: _generateRoute,
      builder: (context, child) {
        return ThemeProvider(
          themeMode: _themeMode,
          onThemeChanged: _setThemeMode,
          child: child!,
        );
      },
    );
  }

  /// Handles navigation based on deeplinks and notifications.
  Route<dynamic>? _generateRoute(RouteSettings settings) {
    // If we're handling a notification or deeplink and the current route is the
    // initial route, handle it specially
    if (settings.name == '/') {
      final notification = NotificationMessage.current;
      if (notification != null) {
        return _handleNotificationRoute(notification);
      }
    }

    // Otherwise, handle normal route generation
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/news_detail':
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['id'] as String;
        return MaterialPageRoute(builder: (_) => NewsDetailPage(id: id));
      case '/event_detail':
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['id'] as String;
        return MaterialPageRoute(builder: (_) => EventDetailPage(id: id));
      // Add more routes as needed
      default:
        return null;
    }
  }

  /// Creates a route based on the notification message.
  Route<dynamic> _handleNotificationRoute(NotificationMessage notification) {
    switch (notification.type) {
      case NotificationType.news:
        return MaterialPageRoute(
          builder: (_) => NewsDetailPage(id: notification.id ?? ''),
        );
      case NotificationType.event:
        return MaterialPageRoute(
          builder: (_) => EventDetailPage(id: notification.id ?? ''),
        );
      // Add more notification types as needed
      default:
        // Default to splash screen which will navigate to home
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }

  /// Updates the theme mode.
  void _setThemeMode(ThemeMode mode) async {
    setState(() {
      _themeMode = mode;
    });

    // Save theme preference to shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.toString());
  }
}

/// A provider that makes theme information available to descendants.
class ThemeProvider extends InheritedWidget {
  /// The current theme mode.
  final ThemeMode themeMode;

  /// Callback for changing the theme mode.
  final ValueChanged<ThemeMode> onThemeChanged;

  /// Creates a new [ThemeProvider].
  const ThemeProvider({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
    required super.child,
  });

  /// Gets the theme information from the closest provider.
  static ThemeProvider of(BuildContext context) {
    final ThemeProvider? result =
        context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
    assert(result != null, 'No ThemeProvider found in context');
    return result!;
  }

  /// Toggles between light and dark theme.
  void toggleTheme() {
    final newMode =
        themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    onThemeChanged(newMode);
  }

  /// Whether the current theme is dark.
  bool get isDarkTheme => themeMode == ThemeMode.dark;

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}

/// A service for handling navigation from anywhere in the app.
class NavigationService {
  /// The global navigator key for pushing routes from anywhere in the app.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Navigates to a page using a named route.
  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  /// Replaces the current route with a new one.
  static Future<dynamic> replaceTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Pops the current route.
  static void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
