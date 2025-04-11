import 'package:flutter/material.dart';

import '../../core/utils/navigation_service.dart';
import '../../core/widgets/base_page.dart';

/// Tenders listing page
class TendersPage extends StatelessWidget {
  /// Parameters passed via deeplink or notification
  final Map<String, dynamic>? parameters;

  const TendersPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'İhale İlanları',
      offlineAccessible: false,
      parameters: parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('İhale İlanları Sayfası'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example of navigating to a tender detail with parameters
                NavigationService.navigateTo(
                  NavigationService.tenderDetail,
                  arguments: {
                    'id': '1',
                    'title': 'Örnek İhale',
                    'endDate': '30 Haziran 2023',
                    'budget': '1.500.000 TL',
                  },
                );
              },
              child: const Text('İhale Detayına Git'),
            ),
          ],
        ),
      ),
    );
  }
}
