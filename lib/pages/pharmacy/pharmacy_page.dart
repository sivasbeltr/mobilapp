import 'package:flutter/material.dart';
import '../../core/widgets/base_page.dart';

/// Displays pharmacies currently on duty
class PharmacyPage extends StatefulWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const PharmacyPage({super.key, this.parameters});

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Nöbetçi Eczaneler',
      offlineAccessible: false,
      parameters: widget.parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_pharmacy,
              size: 72,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'Nöbetçi Eczane Listesi',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
