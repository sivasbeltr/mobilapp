import 'package:flutter/material.dart';
import '../../core/utils/navigation_service.dart';

/// Quick access links specifically for offline mode
class OfflineQuickLinks extends StatelessWidget {
  const OfflineQuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    // Quick links data for offline mode only
    final List<Map<String, dynamic>> quickLinks = [
      {
        'title': 'Acil Durumlar',
        'icon': Icons.emergency_outlined,
        'gradient': const LinearGradient(
          colors: [Color(0xFFE74C3C), Color(0xFFFF5E57)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': NavigationService.emergency,
      },
      {
        'title': 'İletişim',
        'icon': Icons.contact_phone,
        'gradient': const LinearGradient(
          colors: [Color(0xFF9B59B6), Color(0xFFA569BD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': NavigationService.contact,
      },
      {
        'title': 'Deprem',
        'icon': Icons.terrain,
        'gradient': const LinearGradient(
          colors: [Color(0xFFC62828), Color(0xFFD32F2F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': NavigationService.earthquakeEmergency,
      },
      {
        'title': 'Yangın',
        'icon': Icons.local_fire_department,
        'gradient': const LinearGradient(
          colors: [Color(0xFFFF6F00), Color(0xFFFF8F00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': NavigationService.fireEmergency,
      },
      {
        'title': 'Sel',
        'icon': Icons.tsunami,
        'gradient': const LinearGradient(
          colors: [Color(0xFF0277BD), Color(0xFF0288D1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': NavigationService.floodEmergency,
      },
      {
        'title': 'İlk Yardım',
        'icon': Icons.medical_services_outlined,
        'gradient': const LinearGradient(
          colors: [Color(0xFF00695C), Color(0xFF00796B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': NavigationService.firstAidEmergency,
      },
      {
        'title': 'Trafik Kazası',
        'icon': Icons.car_crash,
        'gradient': const LinearGradient(
          colors: [Color(0xFF283593), Color(0xFF303F9F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': NavigationService.trafficAccidentEmergency,
      },
      {
        'title': 'Acil Tıbbi',
        'icon': Icons.health_and_safety_outlined,
        'gradient': const LinearGradient(
          colors: [Color(0xFFD81B60), Color(0xFFE91E63)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': NavigationService.lifeThreateningEmergency,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Row(
          children: [
            Container(
              height: 24,
              width: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Hızlı Erişim',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.titleLarge?.color,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Quick links grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          childAspectRatio: 0.85,
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
          children:
              quickLinks.map((linkData) {
                return _buildQuickLinkIcon(context, linkData);
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickLinkIcon(
    BuildContext context,
    Map<String, dynamic> linkData,
  ) {
    // Split title into words
    final words = linkData['title'].toString().split(' ');

    return GestureDetector(
      onTap: () => NavigationService.navigateTo(linkData['route']),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // Add clip to prevent color leakage
          boxShadow: [
            BoxShadow(
              color: (linkData['gradient'] as LinearGradient).colors.first
                  .withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          // Clip to fix color leakage
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(gradient: linkData['gradient']),
            child: Stack(
              children: [
                // Subtle glass effect overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        linkData['icon'],
                        size: 30,
                        color: Colors.white.withOpacity(0.95),
                      ),
                      const SizedBox(height: 6),
                      Column(
                        children:
                            words.map((word) {
                              return Text(
                                word,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
