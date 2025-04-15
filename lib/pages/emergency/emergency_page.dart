import 'package:flutter/material.dart';
import 'package:sivas_belediyesi/core/widgets/pages_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/emergency_contact_grid.dart';
import 'widgets/emergency_header.dart';
import 'widgets/emergency_type_list.dart';

/// Emergency page with important contact information and instructions
/// This page works offline for critical accessibility during emergencies
class EmergencyPage extends StatefulWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const EmergencyPage({super.key, this.parameters});

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PagesAppBar(
        title: 'Acil Durumlar',
        showBackButton: true,
        showLogo: true,
        hasElevation: true,
        elevationValue: 3,
        useRoundedBottom: false,
        useGradientBackground: false,
        backIcon: Icons.arrow_back_ios_rounded,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency header with warning message
            const EmergencyHeader(),

            // Important emergency contacts
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  16, 32, 16, 8), // Increased top padding
              child: Text(
                'Acil Yardım Numaraları',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: EmergencyContactGrid(
                onTap: (String phoneNumber) async {
                  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
                  if (await canLaunchUrl(phoneUri)) {
                    await launchUrl(phoneUri);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Arama yapılamıyor.')),
                    );
                  }
                },
              ),
            ),

            // Emergency types and instructions
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                'Acil Durum Talimatları',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                'Aşağıdaki durumlarda yapılması gerekenler hakkında bilgi alın',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: EmergencyTypeList(),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
