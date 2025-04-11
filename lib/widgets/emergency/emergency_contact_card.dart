import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../client/models/emergency_contact.dart';
import '../../core/utils/icon_mapper.dart';

/// A card widget for displaying an emergency contact
class EmergencyContactCard extends StatelessWidget {
  /// Contact information to display
  final EmergencyContact contact;

  /// Constructor for EmergencyContactCard
  const EmergencyContactCard({required this.contact, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => _callEmergencyNumber(contact.phoneNumber),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                IconMapper.getIconData(contact.iconName),
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                contact.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  contact.phoneNumber,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Launch phone dialer with emergency number
  Future<void> _callEmergencyNumber(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $uri');
    }
  }
}
