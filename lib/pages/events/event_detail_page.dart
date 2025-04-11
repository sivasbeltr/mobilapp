import 'package:flutter/material.dart';

import '../../core/widgets/base_page.dart';

/// Event detail page that displays a specific event
class EventDetailPage extends StatelessWidget {
  /// Parameters passed via deeplink or notification
  /// Expected parameters: id, title, date, etc.
  final Map<String, dynamic>? parameters;

  const EventDetailPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    // Extract the parameters
    final String id = parameters?['id'] ?? 'unknown';
    final String title = parameters?['title'] ?? 'Etkinlik Detayı';
    final String date = parameters?['date'] ?? 'Tarih bilgisi yok';

    return BasePage(
      title: title,
      offlineAccessible: false,
      parameters: parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Etkinlik ID: $id'),
            const SizedBox(height: 20),
            Text('Etkinlik Başlığı: $title'),
            const SizedBox(height: 20),
            Text('Etkinlik Tarihi: $date'),
          ],
        ),
      ),
    );
  }
}
