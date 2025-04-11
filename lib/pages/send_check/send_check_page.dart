import 'package:flutter/material.dart';
import '../../core/widgets/base_page.dart';

/// Page for sending photos to municipality
class SendCheckPage extends StatefulWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const SendCheckPage({super.key, this.parameters});

  @override
  State<SendCheckPage> createState() => _SendCheckPageState();
}

class _SendCheckPageState extends State<SendCheckPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Çek Gönder',
      offlineAccessible: false,
      parameters: widget.parameters,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_camera,
              size: 72,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Fotoğraf Çek ve Gönder',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
