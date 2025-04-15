import 'package:flutter/material.dart';

import '../../../../client/models/department_detail_model.dart';

/// A widget that displays the department header with title and visual elements
class DepartmentHeaderWidget extends StatelessWidget {
  /// The department detail model
  final DepartmentDetailModel department;

  /// Creates a [DepartmentHeaderWidget]
  const DepartmentHeaderWidget({
    Key? key,
    required this.department,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Extract icon from the extra field if available
    final icon = department.extra.isNotEmpty &&
            department.extra[0].fieldFirst != null &&
            department.extra[0].fieldFirst!.isNotEmpty
        ? department.extra[0].fieldFirst
        : null;

    return Container(
      color: theme.colorScheme.primaryContainer.withAlpha(50),
      child: Column(
        children: [
          // Department icon and title
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Department icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withAlpha(15),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: icon != null
                        ? _buildHtmlIcon(context, icon)
                        : Icon(
                            Icons.business,
                            size: 30,
                            color: theme.colorScheme.primary,
                          ),
                  ),
                ),

                const SizedBox(width: 16),

                // Department title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        department.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (department.date.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Güncellenme: ${department.date}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(160),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom decoration line
          Container(
            height: 6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withAlpha(120),
                  theme.colorScheme.primary.withAlpha(0),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds an icon from HTML string
  Widget _buildHtmlIcon(BuildContext context, String htmlIcon) {
    final theme = Theme.of(context);

    // For simplicity, extract the icon name from the HTML
    final iconNameRegex = RegExp(r'fa-([a-z-]+)');
    final match = iconNameRegex.firstMatch(htmlIcon);
    final iconName = match?.group(1) ?? 'building';

    // Map common icon names to MaterialIcons
    IconData iconData;
    switch (iconName) {
      case 'house-chimney-crack':
        iconData = Icons.home_work;
        break;
      case 'building':
        iconData = Icons.business;
        break;
      case 'city':
        iconData = Icons.location_city;
        break;
      case 'landmark':
        iconData = Icons.account_balance;
        break;
      case 'road':
        iconData = Icons.add_road;
        break;
      case 'tree':
        iconData = Icons.park;
        break;
      case 'water':
        iconData = Icons.water;
        break;
      case 'trash':
        iconData = Icons.delete;
        break;
      case 'bus':
        iconData = Icons.directions_bus;
        break;
      case 'users':
        iconData = Icons.people;
        break;
      case 'sack-dollar':
        iconData = Icons.attach_money;
        break;
      default:
        iconData = Icons.business;
        break;
    }

    return Icon(
      iconData,
      size: 30,
      color: theme.colorScheme.primary,
    );
  }
}
