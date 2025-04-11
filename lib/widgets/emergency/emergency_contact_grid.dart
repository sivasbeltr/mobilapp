import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Grid of emergency contact numbers
class EmergencyContactGrid extends StatelessWidget {
  const EmergencyContactGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> emergencyContacts = [
      {
        'name': 'Acil Yardım',
        'number': '112',
        'icon': Icons.emergency,
        'color': const Color(0xFFD32F2F), // Red
      },
      {
        'name': 'Polis',
        'number': '155',
        'icon': Icons.local_police,
        'color': const Color(0xFF1565C0), // Blue
      },
      {
        'name': 'Jandarma',
        'number': '156',
        'icon': Icons.shield,
        'color': const Color(0xFF2E7D32), // Green
      },
      {
        'name': 'İtfaiye',
        'number': '110',
        'icon': Icons.local_fire_department,
        'color': const Color(0xFFE65100), // Orange
      },
      {
        'name': 'Sağlık',
        'number': '184',
        'icon': Icons.health_and_safety,
        'color': const Color(0xFF4527A0), // Purple
      },
      {
        'name': 'AFAD',
        'number': '122',
        'icon': Icons.tsunami,
        'color': const Color(0xFF00838F), // Teal
      },
      {
        'name': 'Belediye',
        'number': '153',
        'icon': Icons.location_city,
        'color': const Color(0xFF558B2F), // Light Green
      },
      {
        'name': 'Orman Yangın',
        'number': '177',
        'icon': Icons.forest,
        'color': const Color(0xFF6D4C41), // Brown
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemCount: emergencyContacts.length,
      itemBuilder: (context, index) {
        final contact = emergencyContacts[index];
        return _buildContactItem(
          context,
          name: contact['name'],
          number: contact['number'],
          icon: contact['icon'],
          color: contact['color'],
        );
      },
    );
  }

  Widget _buildContactItem(
    BuildContext context, {
    required String name,
    required String number,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => _makeEmergencyCall(context, number),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withOpacity(0.3), width: 1.5),
              ),
              child: Center(child: Icon(icon, size: 32, color: color)),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            number,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makeEmergencyCall(BuildContext context, String number) async {
    final Uri phoneUri = Uri.parse('tel:$number');

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        // Show error if can't launch phone app
        // ignore: use_build_context_synchronously
        _showCallErrorDialog(context, number);
      }
    } catch (e) {
      // Handle any exceptions
      // ignore: use_build_context_synchronously
      _showCallErrorDialog(context, number);
    }
  }

  void _showCallErrorDialog(BuildContext context, String number) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Arama Yapılamadı'),
          content: Text('$number numarasını manuel olarak arayın.'),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: number));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Numara kopyalandı')),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Numarayı Kopyala'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
}
