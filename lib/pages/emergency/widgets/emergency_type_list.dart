import 'package:flutter/material.dart';
import 'package:sivas_belediyesi/pages/emergency/fire_page.dart';
import 'package:sivas_belediyesi/pages/emergency/flood_page.dart';
import 'package:sivas_belediyesi/pages/emergency/traffic_accident_page.dart';
import '../earthquake_page.dart';
import '../first_aid_page.dart';
import '../life_threatening_page.dart';
// Add other emergency pages as they become available

/// List of different emergency types with instruction links
class EmergencyTypeList extends StatelessWidget {
  const EmergencyTypeList({super.key});

  @override
  Widget build(BuildContext context) {
    final emergencyTypes = <Map<String, dynamic>>[
      {
        'title': 'Deprem',
        'icon': Icons.terrain,
        'description': 'Deprem anında ve sonrasında yapılması gerekenler',
        'page': const EarthquakePage(),
        'color': const Color(0xFFC62828),
      },
      {
        'title': 'Yangın',
        'icon': Icons.local_fire_department,
        'description': 'Yangın anında alınması gereken önlemler',
        'page': const FirePage(), // Replace with actual page
        'color': const Color(0xFFFF6F00),
      },
      {
        'title': 'Sel ve Su Baskını',
        'icon': Icons.tsunami,
        'description': 'Sel ve su baskını durumunda yapılması gerekenler',
        'page': const FloodPage(), // Replace with actual page
        'color': const Color(0xFF0277BD),
      },
      {
        'title': 'Trafik Kazası',
        'icon': Icons.car_crash,
        'description':
            'Trafik kazası durumunda ilk yardım ve yapılması gerekenler',
        'page': const TrafficAccidentPage(), // Replace with actual page
        'color': const Color(0xFF283593),
      },
      {
        'title': 'İlk Yardım',
        'icon': Icons.medical_services,
        'description': 'Temel ilk yardım bilgileri ve uygulamaları',
        'page': const FirstAidPage(), // Replace with actual page
        'color': const Color(0xFF00695C),
      },
      {
        'title': 'Hayatı Tehdit Eden Durumlar',
        'icon': Icons.health_and_safety,
        'description':
            'Kalp krizi, boğulma gibi acil durumlarda yapılması gerekenler',
        'page': const LifeThreateningPage(), // Replace with actual page
        'color': const Color(0xFFD81B60),
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: emergencyTypes.length,
      itemBuilder: (context, index) {
        final item = emergencyTypes[index];
        return _buildEmergencyTypeCard(
          context,
          title: item['title'] as String,
          icon: item['icon'] as IconData,
          description: item['description'] as String,
          page: item['page'] as Widget,
          color: item['color'] as Color,
        );
      },
    );
  }

  Widget _buildEmergencyTypeCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String description,
    required Widget page,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withAlpha(76), width: 1.5),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: color.withAlpha(178)),
            ],
          ),
        ),
      ),
    );
  }
}
