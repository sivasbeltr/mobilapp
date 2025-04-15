import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'home_page_state.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_page_carousel.dart';
import 'widgets/home_quick_access.dart';
import 'widgets/home_services_section.dart';
import 'widgets/home_news_section.dart';
import 'widgets/home_events_section.dart';

/// HomePage is the main screen of the application after successful loading.
class HomePage extends StatefulWidget {
  /// Creates a new [HomePage].
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageState _state = HomePageState();

  @override
  void initState() {
    super.initState();
    _initializeHomePage();
  }

  /// Initializes the home page by loading necessary data.
  Future<void> _initializeHomePage() async {
    await _state.initialize();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const HomeAppBar(),
      body: RefreshIndicator(
        onRefresh: _initializeHomePage,
        color: AppColors.primary,
        child: _buildHomeContent(),
      ),
    );
  }

  /// Builds the main content of the home page.
  Widget _buildHomeContent() {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const SizedBox(height: 8),

        // Carousel with featured content
        HomePageCarousel(items: _state.carouselItems),

        const SizedBox(height: 16),

        // Quick access section
        const HomeQuickAccess(),

        const SizedBox(height: 16),

        // Municipal services section
        HomeServicesSection(services: _state.services),

        const SizedBox(height: 16),

        // News section
        HomeNewsSection(news: _state.news),

        const SizedBox(height: 16),

        // Events section
        HomeEventsSection(events: _state.events),
      ],
    );
  }
}
