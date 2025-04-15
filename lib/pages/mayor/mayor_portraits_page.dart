import 'package:flutter/material.dart';
import '../../core/widgets/pages_app_bar.dart';

/// A page that displays portraits of the mayor.
/// This is currently a placeholder page.
class MayorPortraitsPage extends StatelessWidget {
  /// Creates a [MayorPortraitsPage].
  const MayorPortraitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const PagesAppBar(
        title: 'Başkan Portreleri',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 80,
              color: theme.colorScheme.primary.withAlpha(120),
            ),
            const SizedBox(height: 24),
            Text(
              'Başkan Portreleri',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Bu bölümde başkanın portreleri yer alacaktır.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
