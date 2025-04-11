import 'package:flutter/material.dart';

import '../../core/widgets/base_page.dart';

/// News detail page that displays a specific news item
class NewsDetailPage extends StatelessWidget {
  /// Parameters passed via deeplink or notification
  /// Expected parameters: id, title, etc.
  final Map<String, dynamic>? parameters;

  const NewsDetailPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    // Extract the parameters
    final String id = parameters?['id'] ?? 'unknown';
    final String title = parameters?['title'] ?? 'Haber Detayı';

    return BasePage(
      title: title,
      offlineAccessible: false,
      parameters: parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Haber ID: $id'),
            const SizedBox(height: 20),
            Text('Haber Başlığı: $title'),
          ],
        ),
      ),
    );
  }
}
