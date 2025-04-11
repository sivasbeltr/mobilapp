import 'package:flutter/material.dart';

// Base pages
import '../../pages/home/home_page.dart';
import '../../pages/offline/offline_home_page.dart';
import '../../pages/splash/splash_page.dart';

// Content pages
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

// Emergency pages
import '../../pages/emergency/emergency_page.dart';
import '../../pages/emergency/earthquake_page.dart';
import '../../pages/emergency/fire_page.dart';
import '../../pages/emergency/flood_page.dart';
import '../../pages/emergency/traffic_accident_page.dart';
import '../../pages/emergency/first_aid_page.dart';
import '../../pages/emergency/life_threatening_page.dart';

// Quick links pages
import '../../pages/contact/contact_page.dart';
// ...existing imports for other quick link pages...

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

  // Emergency routes
  static const String emergency = '/emergency';
  static const String earthquakeEmergency = '/emergency/earthquake';
  static const String fireEmergency = '/emergency/fire';
  static const String floodEmergency = '/emergency/flood';
  static const String trafficAccidentEmergency = '/emergency/traffic-accident';
  static const String firstAidEmergency = '/emergency/first-aid';
  static const String lifeThreateningEmergency = '/emergency/life-threatening';

  // Quick links routes
  static const String transportation = '/transportation';
  static const String sendCheck = '/send-check';
  static const String marriage = '/marriage';
  static const String contact = '/contact';
  static const String complaints = '/complaints';
  static const String water = '/water-service';
  static const String pharmacy = '/pharmacy';

  /// Route generator for the MaterialApp
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Map<String, dynamic>? args =
        settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      // Base routes
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

      // Content routes
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

      // Emergency routes
      case emergency:
        return MaterialPageRoute(
          builder: (_) => EmergencyPage(parameters: args),
          settings: settings,
        );
      case earthquakeEmergency:
        return MaterialPageRoute(
          builder: (_) => EarthquakePage(parameters: args),
          settings: settings,
        );
      case fireEmergency:
        return MaterialPageRoute(
          builder: (_) => FirePage(parameters: args),
          settings: settings,
        );
      case floodEmergency:
        return MaterialPageRoute(
          builder: (_) => FloodPage(parameters: args),
          settings: settings,
        );
      case trafficAccidentEmergency:
        return MaterialPageRoute(
          builder: (_) => TrafficAccidentPage(parameters: args),
          settings: settings,
        );
      case firstAidEmergency:
        return MaterialPageRoute(
          builder: (_) => FirstAidPage(parameters: args),
          settings: settings,
        );
      case lifeThreateningEmergency:
        return MaterialPageRoute(
          builder: (_) => LifeThreateningPage(parameters: args),
          settings: settings,
        );

      // Quick links routes - add as implemented
      case contact:
        return MaterialPageRoute(
          builder: (_) => ContactPage(parameters: args),
          settings: settings,
        );
      // Add other quick link routes as they're implemented

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
