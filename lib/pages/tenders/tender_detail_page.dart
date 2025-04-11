import 'package:flutter/material.dart';

import '../../core/widgets/base_page.dart';

/// Tender detail page that displays a specific tender
class TenderDetailPage extends StatelessWidget {
  /// Parameters passed via deeplink or notification
  /// Expected parameters: id, title, endDate, budget, etc.
  final Map<String, dynamic>? parameters;

  const TenderDetailPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    // Extract the parameters
    final String id = parameters?['id'] ?? 'unknown';
    final String title = parameters?['title'] ?? 'İhale Detayı';
    final String endDate = parameters?['endDate'] ?? 'Son tarih bilgisi yok';
    final String budget = parameters?['budget'] ?? 'Bütçe bilgisi yok';

    return BasePage(
      title: title,
      offlineAccessible: false,
      parameters: parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('İhale ID: $id'),
            const SizedBox(height: 20),
            Text('İhale Başlığı: $title'),
            const SizedBox(height: 20),
            Text('Son Tarih: $endDate'),
            const SizedBox(height: 20),
            Text('Bütçe: $budget'),
          ],
        ),
      ),
    );
  }
}
