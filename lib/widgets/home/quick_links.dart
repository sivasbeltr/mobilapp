import 'package:flutter/material.dart';

/// Quick access links to important services
class QuickLinks extends StatelessWidget {
  const QuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    // Quick links data
    final List<Map<String, dynamic>> quickLinks = [
      {
        'title': 'Borç\nÖdeme',
        'icon': Icons.payments_outlined,
        'color': const Color(0xFF2E86C1),
        'route': '/payments',
      },
      {
        'title': 'Ulaşım\nHatları',
        'icon': Icons.directions_bus_filled_outlined,
        'color': const Color(0xFF16A085),
        'route': '/transportation',
      },
      {
        'title': 'Nikah\nİşlemleri',
        'icon': Icons.favorite_border_outlined,
        'color': const Color(0xFFE74C3C),
        'route': '/marriage',
      },
      {
        'title': 'İletişim',
        'icon': Icons.headset_mic_outlined,
        'color': const Color(0xFF9B59B6),
        'route': '/contact',
      },
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          quickLinks.length,
          (index) => _QuickLinkButton(
            title: quickLinks[index]['title'],
            icon: quickLinks[index]['icon'],
            color: quickLinks[index]['color'],
            onTap: () {
              // TODO: Navigate to route
            },
          ),
        ),
      ),
    );
  }
}

class _QuickLinkButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickLinkButton({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
