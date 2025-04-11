import 'package:flutter/material.dart';

import '../../core/utils/navigation_service.dart';
import '../../core/widgets/base_page.dart';

/// Announcements listing page
class AnnouncementsPage extends StatelessWidget {
  /// Parameters passed via deeplink or notification
  final Map<String, dynamic>? parameters;

  const AnnouncementsPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Duyurular',
      offlineAccessible: false,
      parameters: parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Duyurular Sayfası'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example of navigating to an announcement detail with parameters
                NavigationService.navigateTo(
                  NavigationService.announcementDetail,
                  arguments: {
                    'id': '1',
                    'title': 'Örnek Duyuru',
                    'date': '20 Mayıs 2023',
                  },
                );
              },
              child: const Text('Duyuru Detayına Git'),
            ),
          ],
        ),
      ),
    );
  }
}
