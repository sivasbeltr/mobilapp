import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../home_page_state.dart';

/// A grid of service categories displayed on the home page.
class HomePageServices extends StatelessWidget {
  /// The service categories to display.
  final List<ServiceItem> services;

  /// Creates a new [HomePageServices] widget.
  const HomePageServices({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _buildServiceItem(context, services[index]);
        },
      ),
    );
  }

  /// Builds a service category item.
  Widget _buildServiceItem(BuildContext context, ServiceItem service) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to service route
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Icon(
              _getIconData(service.icon),
              size: 36,
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            // Service name
            Text(
              service.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
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
      default:
        return Icons.info;
    }
  }
}
