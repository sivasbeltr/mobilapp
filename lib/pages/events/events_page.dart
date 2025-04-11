import 'package:flutter/material.dart';

import '../../core/utils/navigation_service.dart';
import '../../core/widgets/base_page.dart';

/// Events listing page
class EventsPage extends StatelessWidget {
  /// Parameters passed via deeplink or notification
  final Map<String, dynamic>? parameters;

  const EventsPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Etkinlikler',
      offlineAccessible: false,
      parameters: parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Etkinlikler Sayfası'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example of navigating to an event detail with parameters
                NavigationService.navigateTo(
                  NavigationService.eventDetail,
                  arguments: {
                    'id': '1',
                    'title': 'Örnek Etkinlik',
                    'date': '15 Mayıs 2023',
                  },
                );
              },
              child: const Text('Etkinlik Detayına Git'),
            ),
          ],
        ),
      ),
    );
  }
}
