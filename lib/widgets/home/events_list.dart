import 'package:flutter/material.dart';
import '../../core/utils/navigation_service.dart';

/// Horizontal scrollable list of upcoming events
class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample event data
    final List<Map<String, dynamic>> events = [
      {
        'id': '1',
        'title': 'Şehir Konseri',
        'date': '15 Mayıs 2023',
        'time': '18:00',
        'location': 'Sivas Kültür Merkezi',
        'image': 'assets/images/sivas_placeholder.jpg',
        'category': 'Konser',
      },
      {
        'id': '2',
        'title': 'Kitap Fuarı',
        'date': '20 Mayıs 2023',
        'time': '10:00',
        'location': 'Fuar Alanı',
        'image': 'assets/images/sivas_placeholder.jpg',
        'category': 'Kültür',
      },
      {
        'id': '3',
        'title': 'Gençlik Festivali',
        'date': '25 Mayıs 2023',
        'time': '14:00',
        'location': 'Kent Meydanı',
        'image': 'assets/images/sivas_placeholder.jpg',
        'category': 'Festival',
      },
      {
        'id': '4',
        'title': 'Spor Etkinlikleri',
        'date': '30 Mayıs 2023',
        'time': '09:00',
        'location': 'Şehir Stadyumu',
        'image': 'assets/images/sivas_placeholder.jpg',
        'category': 'Spor',
      },
      {
        'id': '5',
        'title': 'Sanat Sergisi',
        'date': '2 Haziran 2023',
        'time': '13:00',
        'location': 'Belediye Sergi Salonu',
        'image': 'assets/images/sivas_placeholder.jpg',
        'category': 'Sanat',
      },
    ];

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;

          return Container(
            width: 270, // Slightly reduced width to prevent overflow
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(16),
              border:
                  isDarkMode
                      ? Border.all(color: Colors.grey[800]!, width: 1)
                      : null,
              boxShadow:
                  isDarkMode
                      ? []
                      : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 0.5,
                          offset: const Offset(0, 2),
                        ),
                      ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  // Navigate to event detail page with parameters
                  NavigationService.navigateTo(
                    NavigationService.eventDetail,
                    arguments: event,
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event image with category badge
                    Stack(
                      children: [
                        // Event image
                        Container(
                          height: 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                isDarkMode
                                    ? Theme.of(
                                      context,
                                    ).colorScheme.primary.withOpacity(0.2)
                                    : Theme.of(
                                      context,
                                    ).colorScheme.primary.withOpacity(0.1),
                          ),
                          child: Image.asset(
                            event['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  _getCategoryIcon(event['category']),
                                  size: 40,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              );
                            },
                          ),
                        ),
                        // Category badge
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              event['category'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Date badge
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color:
                                  isDarkMode ? Colors.grey[800] : Colors.white,
                              shape: BoxShape.circle,
                              boxShadow:
                                  isDarkMode
                                      ? []
                                      : [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                            ),
                            child: Icon(
                              Icons.date_range,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Event details with better sizing and spacing
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  15, // Slightly smaller to prevent overflow
                              color:
                                  Theme.of(
                                    context,
                                  ).textTheme.titleMedium?.color,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Date, time and location row with better spacing
                          LayoutBuilder(
                            builder: (context, constraints) {
                              // Size calculations to prevent overflows
                              return Row(
                                children: [
                                  // Date and time with fixed width
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: constraints.maxWidth * 0.55,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 12,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                        ),
                                        const SizedBox(width: 4),
                                        Flexible(
                                          child: Text(
                                            '${event['date']} • ${event['time']}',
                                            style: TextStyle(
                                              fontSize:
                                                  11, // Smaller for better fit
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodySmall?.color,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Spacer(),

                                  // Location with remaining width
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: constraints.maxWidth * 0.4,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 12,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                        ),
                                        const SizedBox(width: 2),
                                        Flexible(
                                          child: Text(
                                            event['location'],
                                            style: TextStyle(
                                              fontSize:
                                                  11, // Smaller for better fit
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodySmall?.color,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(String? category) {
    switch (category?.toLowerCase()) {
      case 'konser':
        return Icons.music_note;
      case 'kültür':
        return Icons.book;
      case 'festival':
        return Icons.celebration;
      case 'spor':
        return Icons.sports_soccer;
      case 'sanat':
        return Icons.palette;
      default:
        return Icons.event;
    }
  }
}
