import 'package:flutter/material.dart';
import '../../core/utils/navigation_service.dart';

/// List of different emergency types with instruction links
class EmergencyTypeList extends StatelessWidget {
  const EmergencyTypeList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> emergencyTypes = [
      {
        'title': 'Deprem',
        'icon': Icons.terrain,
        'description': 'Deprem anında ve sonrasında yapılması gerekenler',
        'route': '/emergency/earthquake',
        'color': const Color(0xFFC62828),
      },
      {
        'title': 'Yangın',
        'icon': Icons.local_fire_department,
        'description': 'Yangın anında alınması gereken önlemler',
        'route': '/emergency/fire',
        'color': const Color(0xFFFF6F00),
      },
      {
        'title': 'Sel ve Su Baskını',
        'icon': Icons.tsunami,
        'description': 'Sel ve su baskını durumunda yapılması gerekenler',
        'route': '/emergency/flood',
        'color': const Color(0xFF0277BD),
      },
      {
        'title': 'Trafik Kazası',
        'icon': Icons.car_crash,
        'description':
            'Trafik kazası durumunda ilk yardım ve yapılması gerekenler',
        'route': '/emergency/traffic-accident',
        'color': const Color(0xFF283593),
      },
      {
        'title': 'İlk Yardım',
        'icon': Icons.medical_services,
        'description': 'Temel ilk yardım bilgileri ve uygulamaları',
        'route': '/emergency/first-aid',
        'color': const Color(0xFF00695C),
      },
      {
        'title': 'Hayatı Tehdit Eden Durumlar',
        'icon': Icons.health_and_safety,
        'description':
            'Kalp krizi, boğulma gibi acil durumlarda yapılması gerekenler',
        'route': '/emergency/life-threatening',
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
          title: item['title'],
          icon: item['icon'],
          description: item['description'],
          route: item['route'],
          color: item['color'],
        );
      },
    );
  }

  Widget _buildEmergencyTypeCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String description,
    required String route,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: InkWell(
        onTap: () => NavigationService.navigateTo(route),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
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
              Icon(Icons.chevron_right, color: color.withOpacity(0.7)),
            ],
          ),
        ),
      ),
    );
  }
}
