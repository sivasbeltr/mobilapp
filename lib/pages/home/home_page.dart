import 'package:flutter/material.dart';

import '../../core/utils/navigation_service.dart';
import '../../core/widgets/base_page.dart';
import '../../widgets/home/announcements_list.dart';
import '../../widgets/home/events_list.dart';
import '../../widgets/home/featured_banner.dart';
import '../../widgets/home/features_grid.dart';
import '../../widgets/home/home_app_bar.dart';
import '../../widgets/home/projects_list.dart';
import '../../widgets/home/quick_links.dart';
import '../../widgets/home/section_header.dart';

/// Main home page for the online mode
class HomePage extends StatefulWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const HomePage({super.key, this.parameters});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List of main features for the home page
  final List<Map<String, dynamic>> _features = [
    {
      'title': 'Duyurular',
      'icon': Icons.campaign,
      'route': NavigationService.announcements,
    },
    {
      'title': 'Haberler',
      'icon': Icons.article,
      'route': NavigationService.news,
    },
    {
      'title': 'Etkinlikler',
      'icon': Icons.event,
      'route': NavigationService.events,
    },
    {
      'title': 'İlanlar',
      'icon': Icons.description,
      'route': NavigationService.ads,
    },
    {
      'title': 'İhale İlanları',
      'icon': Icons.gavel,
      'route': NavigationService.tenders,
    },
    {
      'title': 'Ulaşım',
      'icon': Icons.directions_bus,
      'route': '/transportation',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const HomeAppBar(), body: _buildBody());
  }

  Widget _buildBody() {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh logic
        },
        color: Theme.of(context).colorScheme.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Featured banner carousel
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: FeaturedBanner(),
              ),

              // Quick links
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: QuickLinks(),
              ),

              // Services section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: Column(
                  children: [
                    const SectionHeader(title: 'Hizmetlerimiz'),
                    FeaturesGrid(features: _features),
                  ],
                ),
              ),

              // Announcements section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: Column(
                  children: [
                    SectionHeader(
                      title: 'Güncel Duyurular',
                      action: TextButton.icon(
                        onPressed: () {
                          NavigationService.navigateTo(
                            NavigationService.announcements,
                          );
                        },
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        label: const Text('Tümü'),
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    ),
                    const AnnouncementsList(),
                  ],
                ),
              ),

              // Projects section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'Projelerimiz',
                      action: TextButton.icon(
                        onPressed: () {
                          // TODO: Navigate to projects page
                        },
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        label: const Text('Tümü'),
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    ),
                    const ProjectsList(),
                  ],
                ),
              ),

              // Events section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Column(
                  children: [
                    SectionHeader(
                      title: 'Etkinlikler',
                      action: TextButton.icon(
                        onPressed: () {
                          NavigationService.navigateTo(
                            NavigationService.events,
                          );
                        },
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        label: const Text('Tümü'),
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    ),
                    const EventsList(),
                  ],
                ),
              ),

              // App info section
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Image.asset(
                    'assets/images/belediye_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Sivas Belediyesi Mobil',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '© ${DateTime.now().year} Tüm Hakları Saklıdır',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
