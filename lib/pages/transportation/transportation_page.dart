import 'package:flutter/material.dart';
import '../../core/widgets/pages_app_bar.dart';

/// TransportationPage displays transportation related information and services.
class TransportationPage extends StatefulWidget {
  /// Creates a new [TransportationPage].
  const TransportationPage({super.key});

  @override
  State<TransportationPage> createState() => _TransportationPageState();
}

class _TransportationPageState extends State<TransportationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PagesAppBar(
        title: 'Ulaşım Hizmetleri',
        showBackButton: true,
        showLogo: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder content - will be replaced with actual content later
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Icon(
                    Icons.directions_bus,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary.withAlpha(128),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Ulaşım Bilgileri',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Bu sayfada yakında ulaşım bilgileri ve hizmetleri sunulacaktır.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
