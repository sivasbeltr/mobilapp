import 'package:flutter/material.dart';
import 'package:sivas_belediyesi/client/models/deputy_mayor_model.dart';
import 'package:sivas_belediyesi/pages/deputy_mayor/deputy_mayor_list_page.dart';
import 'package:sivas_belediyesi/pages/send_check/send_check_page.dart';
import '../../../core/theme/app_colors.dart';
import '../../../pages/emergency/emergency_page.dart';
import '../../cityguide/cityguide_page.dart';
import '../../transportation/transportation_page.dart';

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
      //çek gönder sayfasına yönlendirilecek
      _QuickAccessItem(
          icon: Icons.send,
          label: 'Çek Gönder',
          color: const Color(0xFF1976D2),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SendCheckPage()));
          }),

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
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DeputyMayorListPage()));
        },
      ),
      _QuickAccessItem(
        icon: Icons.camera_alt,
        label: 'Kent Kameraları',
        color: Colors.indigo,
        onTap: () {
          // TODO: Navigate to city cameras page
        },
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hızlı Erişim',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Dynamic scroll indicator
                  Row(
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
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 90,
              child: ListView.builder(
                controller: _scrollController, // Attach controller
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemCount: quickAccessItems.length,
                itemBuilder: (context, index) {
                  return _buildQuickAccessItem(
                    context,
                    quickAccessItems[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a quick access item with icon and label.
  Widget _buildQuickAccessItem(BuildContext context, _QuickAccessItem item) {
    return Container(
      width: 70,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: item.onTap,
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: item.color.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                size: 30,
                color: item.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.textPrimaryLight
                    : AppColors.textPrimaryDark,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
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
