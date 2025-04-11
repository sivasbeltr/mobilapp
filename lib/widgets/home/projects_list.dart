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

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final project = projects[index];
          final double completion = project['completion'] as double;
          final bool isCompleted = completion >= 1.0;

          return Container(
            width: 300,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).cardTheme.color,
              boxShadow: [
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
                          Image.asset(
                            project['image'],
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          // Status indicator
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isCompleted
                                        ? Colors.green
                                        : Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(30),
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
                          // Progress bar at bottom of image
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                              child: LinearProgressIndicator(
                                value: completion,
                                backgroundColor: Colors.black.withOpacity(0.2),
                                color:
                                    isCompleted
                                        ? Colors.green
                                        : Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                minHeight: 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Project details
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
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
