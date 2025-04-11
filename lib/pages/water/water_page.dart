import 'package:flutter/material.dart';
import '../../core/widgets/base_page.dart';

/// Water issues and service requests page
class WaterPage extends StatefulWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const WaterPage({super.key, this.parameters});

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Su Arıza',
      offlineAccessible: false,
      parameters: widget.parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.water_drop,
              size: 72,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Su Arıza Bildirimi',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
