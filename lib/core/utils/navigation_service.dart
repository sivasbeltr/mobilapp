import 'package:flutter/material.dart';

import '../../pages/home/home_page.dart';
import '../../pages/offline/offline_home_page.dart';
import '../../pages/splash/splash_page.dart';
import '../../pages/news/news_page.dart';
import '../../pages/news/news_detail_page.dart';
import '../../pages/events/events_page.dart';
import '../../pages/events/event_detail_page.dart';
import '../../pages/announcements/announcements_page.dart';
import '../../pages/announcements/announcement_detail_page.dart';
import '../../pages/ads/ads_page.dart';
import '../../pages/ads/ad_detail_page.dart';
import '../../pages/tenders/tenders_page.dart';
import '../../pages/tenders/tender_detail_page.dart';

/// Service for handling navigation throughout the app.
/// Supports named routes and deep linking.
class NavigationService {
  /// Global navigation key for accessing navigator from anywhere
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// The route names used for navigation
  static const String splash = '/splash';
  static const String home = '/home';
  static const String offlineHome = '/offline-home';

  // News routes
  static const String news = '/news';
  static const String newsDetail = '/news/detail';

  // Events routes
  static const String events = '/events';
  static const String eventDetail = '/events/detail';

  // Announcements routes
  static const String announcements = '/announcements';
  static const String announcementDetail = '/announcements/detail';

  // Ads routes
  static const String ads = '/ads';
  static const String adDetail = '/ads/detail';

  // Tenders routes
  static const String tenders = '/tenders';
  static const String tenderDetail = '/tenders/detail';

  /// Route generator for the MaterialApp
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Map<String, dynamic>? args =
        settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => HomePage(parameters: args),
          settings: settings,
        );
      case offlineHome:
        return MaterialPageRoute(
          builder: (_) => OfflineHomePage(parameters: args),
          settings: settings,
        );
      case news:
        return MaterialPageRoute(
          builder: (_) => NewsPage(parameters: args),
          settings: settings,
        );
      case newsDetail:
        return MaterialPageRoute(
          builder: (_) => NewsDetailPage(parameters: args),
          settings: settings,
        );
      case events:
        return MaterialPageRoute(
          builder: (_) => EventsPage(parameters: args),
          settings: settings,
        );
      case eventDetail:
        return MaterialPageRoute(
          builder: (_) => EventDetailPage(parameters: args),
          settings: settings,
        );
      case announcements:
        return MaterialPageRoute(
          builder: (_) => AnnouncementsPage(parameters: args),
          settings: settings,
        );
      case announcementDetail:
        return MaterialPageRoute(
          builder: (_) => AnnouncementDetailPage(parameters: args),
          settings: settings,
        );
      case ads:
        return MaterialPageRoute(
          builder: (_) => AdsPage(parameters: args),
          settings: settings,
        );
      case adDetail:
        return MaterialPageRoute(
          builder: (_) => AdDetailPage(parameters: args),
          settings: settings,
        );
      case tenders:
        return MaterialPageRoute(
          builder: (_) => TendersPage(parameters: args),
          settings: settings,
        );
      case tenderDetail:
        return MaterialPageRoute(
          builder: (_) => TenderDetailPage(parameters: args),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
    }
  }

  /// Navigate to a named route
  static Future<dynamic> navigateTo(
    String routeName, {
    Map<String, dynamic>? arguments,
  }) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Replace current route with a new one
  static Future<dynamic> replaceTo(
    String routeName, {
    Map<String, dynamic>? arguments,
  }) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Pop to the previous route
  static void goBack() {
    navigatorKey.currentState!.pop();
  }

  /// Pop until a specific route
  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }
}
