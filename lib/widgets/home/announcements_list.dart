import 'package:flutter/material.dart';
import '../../core/utils/navigation_service.dart';

/// Displays recent municipality announcements in a list
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
        'description':
            'Şehir merkezi ve çevre mahallelerde bakım çalışması nedeniyle su kesintisi yapılacaktır.',
      },
      {
        'id': '2',
        'title': 'Belediye Hizmet Binası Taşınma Duyurusu',
        'date': '5 Mayıs 2023',
        'description': 'Hizmet binamız yeni adresine taşınmıştır.',
      },
      {
        'id': '3',
        'title': 'Sokak Hayvanları Aşılama Kampanyası',
        'date': '1 Mayıs 2023',
        'description':
            'Sokak hayvanları için aşılama kampanyası başlatılmıştır.',
      },
    ];

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemCount: announcements.length,
      separatorBuilder:
          (context, index) => Divider(
            height: 1,
            thickness: 1,
            color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
            indent: 16,
            endIndent: 16,
          ),
      itemBuilder: (context, index) {
        final announcement = announcements[index];

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              NavigationService.navigateTo(
                NavigationService.announcementDetail,
                arguments: announcement,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Announcement icon with date indicator
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.campaign,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Announcement content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          announcement['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color:
                                Theme.of(context).textTheme.titleMedium?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          announcement['description'],
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        // Date indicator
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 12,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              announcement['date'],
                              style: TextStyle(
                                fontSize: 11,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Right arrow indicator
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
