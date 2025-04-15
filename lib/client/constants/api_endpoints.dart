/// API endpoints for the Sivas Municipality mobile application.
class ApiEndpoints {
  /// Base URL for all API requests.
  static const String baseUrl = 'https://www.sivas.bel.tr/api';

  /// News endpoints
  static const String news = '/haberler';
  static const String newsDetail = '/haberler/detay';

  /// Events endpoints
  static const String events = '/etkinlikler';
  static const String eventsDetail = '/etkinlikler/detay';

  /// Announcements endpoints
  static const String announcements = '/duyurular';
  static const String announcementsDetail = '/duyurular/detay';

  /// Tenders endpoints
  static const String tenders = '/ihaleler';
  static const String tendersDetail = '/ihaleler/detay';

  /// Projects endpoints
  static const String projects = '/projeler';
  static const String projectsDetail = '/projeler/detay';
}
