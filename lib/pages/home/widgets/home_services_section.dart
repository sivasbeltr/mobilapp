import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../home_page_state.dart';
import 'shared_section_styles.dart';

/// A section displaying municipal services in a visually appealing grid layout.
class HomeServicesSection extends StatelessWidget {
  /// The services to display.
  final List<ServiceItem> services;

  /// Creates a new [HomeServicesSection].
  const HomeServicesSection({
    super.key,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return SharedSectionContainer(
      title: 'Belediye Hizmetleri',
      icon: Icons.miscellaneous_services,
      trailing: TextButton(
        onPressed: () {
          // TODO: Navigate to all services page
        },
        child: const Text('Tümü'),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.88,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: services.length > 9
              ? 9
              : services.length, // Show up to 9 items (3 rows of 3)
          itemBuilder: (context, index) {
            return _buildServiceItem(context, services[index]);
          },
        ),
      ),
    );
  }

  /// Builds a service item with icon on top and text at the bottom.
  Widget _buildServiceItem(BuildContext context, ServiceItem service) {
    return SharedGridItem(
      icon: _getIconData(service.icon),
      title: service.name,
      color: AppColors.primary,
      onTap: () {
        // TODO: Navigate to service route
      },
    );
  }

  /// Converts a string icon name to an IconData.
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'business':
        return Icons.business;
      case 'account_balance':
        return Icons.account_balance;
      case 'event':
        return Icons.event;
      case 'announcement':
        return Icons.announcement;
      case 'library_books':
        return Icons.library_books;
      case 'public':
        return Icons.public;
      case 'local_parking':
        return Icons.local_parking;
      case 'water':
        return Icons.water_drop;
      case 'construction':
        return Icons.construction;
      case 'payments':
        return Icons.payments;
      case 'local_activity':
        return Icons.local_activity;
      case 'contact_mail':
        return Icons.contact_mail;
      default:
        return Icons.info;
    }
  }
}
