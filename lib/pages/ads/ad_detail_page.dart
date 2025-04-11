import 'package:flutter/material.dart';

import '../../core/widgets/base_page.dart';

/// Ad detail page that displays a specific ad
class AdDetailPage extends StatelessWidget {
  /// Parameters passed via deeplink or notification
  /// Expected parameters: id, title, category, etc.
  final Map<String, dynamic>? parameters;

  const AdDetailPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    // Extract the parameters
    final String id = parameters?['id'] ?? 'unknown';
    final String title = parameters?['title'] ?? 'İlan Detayı';
    final String category = parameters?['category'] ?? 'Kategori bilgisi yok';

    return BasePage(
      title: title,
      offlineAccessible: false,
      parameters: parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('İlan ID: $id'),
            const SizedBox(height: 20),
            Text('İlan Başlığı: $title'),
            const SizedBox(height: 20),
            Text('İlan Kategorisi: $category'),
          ],
        ),
      ),
    );
  }
}
