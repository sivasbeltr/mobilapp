import 'package:flutter/material.dart';

import '../../core/utils/navigation_service.dart';
import '../../core/widgets/base_page.dart';

/// Ads listing page
class AdsPage extends StatelessWidget {
  /// Parameters passed via deeplink or notification
  final Map<String, dynamic>? parameters;

  const AdsPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'İlanlar',
      offlineAccessible: false,
      parameters: parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('İlanlar Sayfası'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example of navigating to an ad detail with parameters
                NavigationService.navigateTo(
                  NavigationService.adDetail,
                  arguments: {
                    'id': '1',
                    'title': 'Örnek İlan',
                    'category': 'Emlak',
                  },
                );
              },
              child: const Text('İlan Detayına Git'),
            ),
          ],
        ),
      ),
    );
  }
}
