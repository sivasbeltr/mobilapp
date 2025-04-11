import 'package:flutter/material.dart';

/// Displays municipality projects in a horizontally scrollable list
class ProjectsList extends StatelessWidget {
  const ProjectsList({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample projects data
    final List<Map<String, dynamic>> projects = [
      {
        'id': '1',
        'title': 'Kent Meydanı Projesi',
        'description': 'Şehir merkezinde modern bir meydan düzenlemesi',
        'status': 'Devam Ediyor',
        'completion': 0.65,
        'image': 'assets/images/sivas_placeholder.jpg',
      },
      {
        'id': '2',
        'title': 'Akıllı Şehir Uygulamaları',
        'description': 'Şehir genelinde dijital dönüşüm uygulamaları',
        'status': 'Planlama',
        'completion': 0.25,
        'image': 'assets/images/sivas_placeholder.jpg',
      },
      {
        'id': '3',
        'title': 'Çevre Düzenlemesi',
        'description': 'Şehir genelinde yeşil alan düzenlemeleri',
        'status': 'Tamamlandı',
        'completion': 1.0,
        'image': 'assets/images/sivas_placeholder.jpg',
      },
    ];

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final project = projects[index];
          final double completion = project['completion'] as double;
          final bool isCompleted = completion >= 1.0;

          // Calculate status color based on completion
          Color statusColor =
              isCompleted
                  ? Colors.green
                  : completion > 0.5
                  ? Colors.orange
                  : Theme.of(context).colorScheme.primary;

          return Container(
            width: 280, // Slightly reduced width to prevent overflow
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).cardTheme.color,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // TODO: Navigate to project details
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project image with status overlay
                      Stack(
                        children: [
                          // Project image with fixed height
                          SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: Image.asset(
                              project['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 120,
                                  width: double.infinity,
                                  color:
                                      isDarkMode
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.primary.withOpacity(0.2)
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.1),
                                  child: Icon(
                                    Icons.architecture,
                                    size: 40,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                );
                              },
                            ),
                          ),

                          // Project completion percentage overlay
                          Positioned(
                            bottom: 26, // Position above progress bar
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${(completion * 100).toInt()}%',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          // Status indicator with better positioning
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow:
                                    isDarkMode
                                        ? []
                                        : [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 4,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isCompleted
                                        ? Icons.check_circle
                                        : Icons.timelapse,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    project['status'],
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Progress bar at bottom of image with smoother appearance
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height:
                                  8, // Slightly taller for better visibility
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: completion,
                                heightFactor: 1.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                        isCompleted ? 0 : 2,
                                      ),
                                      bottomRight: Radius.circular(
                                        isCompleted ? 0 : 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Project details with better padding and overflow handling
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.color,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              project['description'],
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
