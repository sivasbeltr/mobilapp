import 'package:flutter/material.dart';
import '../../core/widgets/base_page.dart';

/// Complaints and suggestions page
class ComplaintsPage extends StatefulWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const ComplaintsPage({super.key, this.parameters});

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Şikayet ve Öneriler',
      offlineAccessible: false,
      parameters: widget.parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.rate_review,
              size: 72,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'Şikayet ve Öneri Formu',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
