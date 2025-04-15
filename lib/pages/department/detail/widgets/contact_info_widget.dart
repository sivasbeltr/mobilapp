import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../client/models/department_detail_model.dart';

/// A widget that displays department contact information
class ContactInfoWidget extends StatelessWidget {
  /// The department detail containing contact information
  final DepartmentDetailModel department;

  /// Creates a [ContactInfoWidget]
  const ContactInfoWidget({
    Key? key,
    required this.department,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Check if contact information is available
    final hasPhone = department.phone != null && department.phone!.isNotEmpty;
    final hasEmail = department.email != null && department.email!.isNotEmpty;

    if (!hasPhone && !hasEmail) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Icon(
                  Icons.contact_phone,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'İletişim Bilgileri',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          // Contact items
          if (hasPhone)
            _buildContactItem(
              context,
              icon: Icons.phone,
              title: 'Telefon',
              value: department.phone!,
              subtitle:
                  department.phoneExt != null && department.phoneExt!.isNotEmpty
                      ? 'Dahili: ${department.phoneExt}'
                      : null,
              onTap: () => _makePhoneCall(department.phone!),
            ),

          if (hasPhone && hasEmail) const SizedBox(height: 8),

          // Email
          if (hasEmail)
            _buildContactItem(
              context,
              icon: Icons.email,
              title: 'E-posta',
              value: department.email!,
              onTap: () => _sendEmail(department.email!),
            ),

          // Divider at bottom
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Divider(),
          ),
        ],
      ),
    );
  }

  /// Builds a contact item with icon, title and value
  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 16,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Launch phone call with the given number
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await _launchUrl(launchUri);
  }

  /// Launch email with the given email address
  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await _launchUrl(launchUri);
  }

  /// Launch a URL
  Future<void> _launchUrl(Uri url) async {
    try {
      await launchUrl(url);
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }
}
