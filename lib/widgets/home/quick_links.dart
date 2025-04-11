import 'package:flutter/material.dart';

/// Compact, aesthetic quick access icons in a grid layout
class QuickLinks extends StatelessWidget {
  const QuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    // Quick links data with reordered items
    final List<Map<String, dynamic>> quickLinks = [
      {
        'title': 'Acil Durumlar',
        'icon': Icons.emergency_outlined,
        'gradient': const LinearGradient(
          colors: [Color(0xFFE74C3C), Color(0xFFFF5E57)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': '/emergency',
      },
      {
        'title': 'Ulaşım Hatları',
        'icon': Icons.directions_bus_filled_outlined,
        'gradient': const LinearGradient(
          colors: [Color(0xFF16A085), Color(0xFF1ABC9C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': '/transportation',
      },
      {
        'title': 'Çek Gönder',
        'icon': Icons.photo_camera,
        'gradient': const LinearGradient(
          colors: [Color(0xFF2E86C1), Color(0xFF3498DB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': '/send-check',
      },
      {
        'title': 'Nikah İşlemleri',
        'icon': Icons.favorite_border_outlined,
        'gradient': const LinearGradient(
          colors: [Color(0xFFF06292), Color(0xFFF48FB1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': '/marriage',
      },
      {
        'title': 'İletişim',
        'icon': Icons.headset_mic_outlined,
        'gradient': const LinearGradient(
          colors: [Color(0xFF9B59B6), Color(0xFFA569BD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': '/contact',
      },
      {
        'title': 'Su Arıza',
        'icon': Icons.water_drop_outlined,
        'gradient': const LinearGradient(
          colors: [Color(0xFF3498DB), Color(0xFF00A8FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': '/water-service',
      },
      {
        'title': 'Şikayet',
        'icon': Icons.rate_review_outlined,
        'gradient': const LinearGradient(
          colors: [Color(0xFFE67E22), Color(0xFFF39C12)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': '/complaints',
      },
      {
        'title': 'Nöbetçi Eczaneler',
        'icon': Icons.local_pharmacy_outlined,
        'gradient': const LinearGradient(
          colors: [Color(0xFF27AE60), Color(0xFF2ECC71)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': '/pharmacy',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16), // Match SectionHeader
          child: Row(
            children: [
              // Accent line to match SectionHeader
              Container(
                height: 24,
                width: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Hızlı Erişim',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          childAspectRatio: 0.85,
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
          padding: const EdgeInsets.only(bottom: 16), // Match SectionHeader
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
      onTap: () {
        // TODO: Navigate to route
        debugPrint('Navigating to ${linkData['route']}');
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: linkData['gradient'],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: (linkData['gradient'] as LinearGradient).colors.first
                  .withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
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
                      size: 32,
                      color: Colors.white.withOpacity(0.95),
                    ),
                    const SizedBox(height: 6),
                    Column(
                      children:
                          words.map((word) {
                            return Text(
                              word,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.2,
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
    );
  }
}
