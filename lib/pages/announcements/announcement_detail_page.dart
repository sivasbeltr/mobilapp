import 'package:flutter/material.dart';

import '../../core/widgets/base_page.dart';

/// Announcement detail page that displays a specific announcement
class AnnouncementDetailPage extends StatelessWidget {
  /// Parameters passed via deeplink or notification
  /// Expected parameters: id, title, date, etc.
  final Map<String, dynamic>? parameters;

  const AnnouncementDetailPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    // Extract the parameters
    final String id = parameters?['id'] ?? 'unknown';
    final String title = parameters?['title'] ?? 'Duyuru Detayı';
    final String date = parameters?['date'] ?? 'Tarih bilgisi yok';

    return BasePage(
      title: title,
      offlineAccessible: false,
      parameters: parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Duyuru ID: $id'),
            const SizedBox(height: 20),
            Text('Duyuru Başlığı: $title'),
            const SizedBox(height: 20),
            Text('Duyuru Tarihi: $date'),
          ],
        ),
      ),
    );
  }
}
