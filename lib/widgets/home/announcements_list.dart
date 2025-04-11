import 'package:flutter/material.dart';
import '../../core/utils/navigation_service.dart';

/// List of announcements for the home page
class AnnouncementsList extends StatelessWidget {
  const AnnouncementsList({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample announcement data
    final List<Map<String, dynamic>> announcements = [
      {
        'id': '1',
        'title': 'Su Kesintisi Duyurusu',
        'date': '10 Mayıs 2023',
        'category': 'Altyapı',
        'urgent': true,
      },
      {
        'id': '2',
        'title': 'Yol Çalışması Duyurusu',
        'date': '12 Mayıs 2023',
        'category': 'Ulaşım',
        'urgent': false,
      },
      {
        'id': '3',
        'title': 'Belediye Meclis Toplantısı',
        'date': '15 Mayıs 2023',
        'category': 'Yönetim',
        'urgent': false,
      },
    ];
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: announcements.length,
      itemBuilder: (context, index) {
        final announcement = announcements[index];
        final bool isUrgent = announcement['urgent'] ?? false;
        
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                spreadRadius: 0.5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                NavigationService.navigateTo(
                  NavigationService.announcementDetail,
                  arguments: announcement,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Category Icon with background
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: isUrgent 
                            ? Theme.of(context).colorScheme.secondary.withOpacity(0.2) 
                            : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          _getCategoryIcon(announcement['category']),
                          color: isUrgent 
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Announcement details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (isUrgent) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Acil',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                              ],
                              Text(
                                announcement['category'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).textTheme.bodySmall?.color,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            announcement['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: isUrgent
                                  ? Theme.of(context).colorScheme.secondary
                                  : null,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 12,
                                color: Theme.of(context).textTheme.bodySmall?.color,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                announcement['date'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).textTheme.bodySmall?.color,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Arrow icon
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  IconData _getCategoryIcon(String? category) {
    switch (category?.toLowerCase()) {
      case 'altyapı':
        return Icons.construction;
      case 'ulaşım':
        return Icons.directions_car;
      case 'yönetim':
        return Icons.groups;
      case 'kültür':
        return Icons.theater_comedy;
      case 'spor':
        return Icons.sports;
      default:
        return Icons.announcement;
    }
  }
}
