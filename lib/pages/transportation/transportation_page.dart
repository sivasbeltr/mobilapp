import 'package:flutter/material.dart';
import '../../core/widgets/base_page.dart';

/// Transportation routes and information page
class TransportationPage extends StatefulWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const TransportationPage({super.key, this.parameters});

  @override
  State<TransportationPage> createState() => _TransportationPageState();
}

class _TransportationPageState extends State<TransportationPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Ulaşım Hatları',
      offlineAccessible: false,
      parameters: widget.parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_bus,
              size: 72,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Otobüs ve Tramvay Hatları',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
