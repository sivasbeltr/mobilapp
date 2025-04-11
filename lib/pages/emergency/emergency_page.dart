import 'package:flutter/material.dart';
import '../../core/widgets/base_page.dart';
import '../../widgets/emergency/emergency_contact_grid.dart';
import '../../widgets/emergency/emergency_type_list.dart';
import '../../widgets/emergency/emergency_header.dart';

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
    return BasePage(
      title: 'Acil Durumlar',
      offlineAccessible: true, // Essential to work offline
      parameters: widget.parameters,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency header with warning message
            const EmergencyHeader(),

            // Important emergency contacts
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Acil Yardım Numaraları',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: EmergencyContactGrid(),
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
