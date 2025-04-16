import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../pages/emergency/emergency_page.dart';
import '../../cityguide/cityguide_page.dart';
import '../../send_check/send_check_page.dart';
import '../../transportation/transportation_page.dart';
import 'shared_section_styles.dart';

/// A quick access section for the home page with essential shortcuts and dynamic scroll indicator.
class HomeQuickAccess extends StatefulWidget {
  /// Creates a new [HomeQuickAccess] widget.
  const HomeQuickAccess({super.key});

  @override
  _HomeQuickAccessState createState() => _HomeQuickAccessState();
}

class _HomeQuickAccessState extends State<HomeQuickAccess> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    // Listen to scroll events to update indicator
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;
        setState(() {
          _scrollProgress =
              maxScroll > 0 ? (currentScroll / maxScroll).clamp(0.0, 1.0) : 0.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List of quick access items
    final quickAccessItems = [
      _QuickAccessItem(
        icon: Icons.emergency,
        label: 'Acil Durum',
        color: const Color(0xFFD32F2F),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EmergencyPage()));
        },
      ),
      _QuickAccessItem(
        icon: Icons.send,
        label: 'Çek Gönder',
        color: const Color(0xFF1976D2),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SendCheckPage()));
        },
      ),
      _QuickAccessItem(
        icon: Icons.bus_alert,
        label: 'Ulaşım',
        color: Colors.blue,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TransportationPage()));
        },
      ),
      _QuickAccessItem(
        icon: Icons.map,
        label: 'Kent Rehberi',
        color: Colors.purple,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CityGuidePage()));
        },
      ),
      _QuickAccessItem(
        icon: Icons.water_drop,
        label: 'Su İşlemleri',
        color: Colors.lightBlue,
        onTap: () {},
      ),
      _QuickAccessItem(
        icon: Icons.camera_roll,
        label: 'Şehir Kameraları',
        color: Colors.indigo,
        onTap: () {},
      ),
      _QuickAccessItem(
        icon: Icons.calendar_month,
        label: 'Etkinlikler',
        color: Colors.orange,
        onTap: () {
          // TODO: Navigate to events page
        },
      ),
      _QuickAccessItem(
        icon: Icons.article,
        label: 'Haberler',
        color: AppColors.primary,
        onTap: () {},
      ),
    ];

    return SharedSectionContainer(
      title: 'Hızlı Erişim',
      icon: Icons.flash_on,
      trailing: _buildScrollIndicator(),
      child: SizedBox(
        height: 85, // Reduced height
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 6), // Reduced padding
          scrollDirection: Axis.horizontal,
          itemCount: quickAccessItems.length,
          itemBuilder: (context, index) {
            final item = quickAccessItems[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 4), // Reduced item padding
              child: SharedCircularItem(
                icon: item.icon,
                title: item.label,
                color: item.color,
                onTap: item.onTap,
              ),
            );
          },
        ),
      ),
    );
  }

  /// Builds a custom scroll indicator for horizontal scrolling
  Widget _buildScrollIndicator() {
    return SizedBox(
      width: 40,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 24 * (1 - _scrollProgress) + 8 * _scrollProgress,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 8 * (1 - _scrollProgress) + 24 * _scrollProgress,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(100),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

/// Model class for quick access items.
class _QuickAccessItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  _QuickAccessItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}
