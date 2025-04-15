import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../client/models/department_detail_model.dart';

/// A widget that displays department sublist items (duties, regulations, etc.)
class SublistInfoWidget extends StatelessWidget {
  /// The department detail containing sublist information
  final DepartmentDetailModel department;

  /// Creates a [SublistInfoWidget]
  const SublistInfoWidget({
    Key? key,
    required this.department,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (department.sublist.isEmpty) {
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
                  Icons.article,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Müdürlük Bilgileri',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          // Sublist items
          ...department.sublist.map((item) => _buildSublistItem(context, item)),

          // Divider at bottom
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Divider(),
          ),
        ],
      ),
    );
  }

  /// Builds a sublist item with an icon and title
  Widget _buildSublistItem(BuildContext context, Sublist item) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => _launchUrl(Uri.parse(item.siteUrl)),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _getIconForSublist(item.title, theme),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get an appropriate icon based on the sublist item title
  Widget _getIconForSublist(String title, ThemeData theme) {
    IconData iconData;

    // Determine the icon based on the title
    if (title.contains('Görev')) {
      iconData = Icons.assignment;
    } else if (title.contains('Yönetmelik')) {
      iconData = Icons.gavel;
    } else if (title.contains('Personel')) {
      iconData = Icons.people;
    } else if (title.contains('Hizmet')) {
      iconData = Icons.handyman;
    } else if (title.contains('Rapor') || title.contains('Faaliyet')) {
      iconData = Icons.assessment;
    } else {
      iconData = Icons.folder;
    }

    return Icon(
      iconData,
      size: 18,
      color: theme.colorScheme.primary,
    );
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
