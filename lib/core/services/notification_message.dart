/// Handles notification messages and deeplinks.
class NotificationMessage {
  /// The type of notification.
  final NotificationType type;

  /// The ID of the content to navigate to.
  final String? id;

  /// The title of the notification.
  final String? title;

  /// Creates a new notification message.
  const NotificationMessage({required this.type, this.id, this.title});

  /// Singleton instance of [NotificationMessage].
  static NotificationMessage? _instance;

  /// Gets the current notification message, or null if none exists.
  static NotificationMessage? get current => _instance;

  /// Initializes the notification message from the provided parameters.
  ///
  /// This should be called when the app starts, or when a notification is received.
  static void init({
    String? type,
    String? id,
    String? title,
    Map<String, dynamic>? data,
  }) {
    if (type == null && data == null) {
      _instance = null;
      return;
    }

    final notificationType = _parseNotificationType(
      type ?? data?['type'] as String?,
    );

    if (notificationType == null) {
      _instance = null;
      return;
    }

    _instance = NotificationMessage(
      type: notificationType,
      id: id ?? data?['id'] as String?,
      title: title ?? data?['title'] as String?,
    );
  }

  /// Clears the current notification message.
  static void clear() {
    _instance = null;
  }

  /// Parses the notification type from a string.
  static NotificationType? _parseNotificationType(String? type) {
    if (type == null) return null;

    switch (type.toLowerCase()) {
      case 'news':
        return NotificationType.news;
      case 'event':
        return NotificationType.event;
      case 'announcement':
        return NotificationType.announcement;
      case 'tender':
        return NotificationType.tender;
      case 'project':
        return NotificationType.project;
      default:
        return null;
    }
  }
}

/// The type of notification.
enum NotificationType {
  /// News notification.
  news,

  /// Event notification.
  event,

  /// Announcement notification.
  announcement,

  /// Tender notification.
  tender,

  /// Project notification.
  project,
}
