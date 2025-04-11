import 'package:flutter/material.dart';
import '../../core/widgets/base_page.dart';

/// Marriage services and appointment page
class MarriagePage extends StatefulWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const MarriagePage({super.key, this.parameters});

  @override
  State<MarriagePage> createState() => _MarriagePageState();
}

class _MarriagePageState extends State<MarriagePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Nikah İşlemleri',
      offlineAccessible: false,
      parameters: widget.parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              size: 72,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Nikah Randevu ve İşlemler',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
