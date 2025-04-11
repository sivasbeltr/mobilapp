import 'package:flutter/material.dart';

import '../../core/utils/navigation_service.dart';
import '../../core/widgets/base_page.dart';

/// News listing page
class NewsPage extends StatelessWidget {
  /// Parameters passed via deeplink or notification
  final Map<String, dynamic>? parameters;

  const NewsPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Haberler',
      offlineAccessible: false,
      parameters: parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Haberler Sayfası'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example of navigating to a news detail with parameters
                NavigationService.navigateTo(
                  NavigationService.newsDetail,
                  arguments: {'id': '1', 'title': 'Örnek Haber'},
                );
              },
              child: const Text('Haber Detayına Git'),
            ),
          ],
        ),
      ),
    );
  }
}
