import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../home_page_state.dart';

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Belediye Hizmetleri',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to all services page
                },
                child: const Text('Tümü'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Changed to 3 columns
              childAspectRatio:
                  0.85, // Adjusted aspect ratio for more square-ish appearance
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            itemCount: services.length > 9
                ? 9
                : services.length, // Show up to 9 items (3 rows of 3)
            itemBuilder: (context, index) {
              return _buildServiceItem(context, services[index]);
            },
          ),
        ],
      ),
    );
  }

  /// Builds a service item with icon on top and text at the bottom.
  Widget _buildServiceItem(BuildContext context, ServiceItem service) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        // TODO: Navigate to service route
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDarkTheme
              ? AppColors.surfaceDark.withAlpha(120)
              : AppColors.primaryContainer.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkTheme
                ? AppColors.primary.withAlpha(60)
                : AppColors.primary.withAlpha(30),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Service icon
            Container(
              width: 48, // Slightly smaller icon container
              height: 48,
              decoration: BoxDecoration(
                color: isDarkTheme
                    ? AppColors.primary.withAlpha(40)
                    : AppColors.primary.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconData(service.icon),
                color: AppColors.primary,
                size: 24, // Slightly smaller icon
              ),
            ),
            const SizedBox(height: 8), // Smaller spacing
            // Service name
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0), // Less padding
              child: Text(
                service.name,
                style: TextStyle(
                  fontSize: 12, // Smaller font size
                  fontWeight: FontWeight.w500,
                  color: isDarkTheme
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
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
