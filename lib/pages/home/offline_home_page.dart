import 'package:flutter/material.dart';

import '../../core/services/connectivity_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/pages_app_bar.dart';
import '../contact/contact_page.dart';
import '../emergency/emergency_page.dart';
import 'home_page.dart';

/// OfflineHomePage displays when the user has no internet connection.
class OfflineHomePage extends StatelessWidget {
  /// Creates a new [OfflineHomePage].
  const OfflineHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PagesAppBar(
        title: 'Sivas Belediyesi',
        showBackButton: false,
        showLogo: true,
        centerTitle: false,
        statusTag: 'Çevrimdışı',
        statusTagColor: AppColors.error,
        statusTagIcon: Icons.wifi_off_rounded,
        useGradientBackground: true,
        hasElevation: true,
        useRoundedBottom: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Internet status card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.red.withAlpha(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.error.withAlpha(15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.wifi_off_rounded,
                              color: AppColors.error,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'İnternet Bağlantısı Yok',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.error,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Bağlantınızı kontrol edin ve tekrar deneyin',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => _retryConnection(context),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Yeniden Dene'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 44),
                          backgroundColor: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Available Offline Services Section
              _buildOfflineServicesSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfflineServicesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.offline_bolt,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Çevrimdışı Erişilebilir Servisler',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 6),
        Text(
          'Aşağıdaki hizmetlere internet bağlantısı olmadan da erişebilirsiniz',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),

        // Grid of offline services
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: [
            _buildOfflineServiceCard(
              context,
              title: 'Acil Durum',
              description: 'İletişim numaraları ve talimatlar',
              icon: Icons.emergency,
              color: AppColors.secondary,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EmergencyPage()),
              ),
            ),
            _buildOfflineServiceCard(
              context,
              title: 'İletişim',
              description: 'Belediye iletişim bilgileri',
              icon: Icons.contact_phone,
              color: AppColors.primary,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactPage()),
              ),
            ),
            // Placeholder cards for future offline services
            _buildOfflineServiceCard(
              context,
              title: 'Yakında',
              description: 'Çalışma aşamasında',
              icon: Icons.more_horiz,
              color: Colors.grey,
              onTap: () => _showComingSoonDialog(context),
              isDisabled: true,
            ),
            _buildOfflineServiceCard(
              context,
              title: 'Yakında',
              description: 'Çalışma aşamasında',
              icon: Icons.more_horiz,
              color: Colors.grey,
              onTap: () => _showComingSoonDialog(context),
              isDisabled: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOfflineServiceCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isDisabled = false,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDisabled ? Colors.grey.withAlpha(60) : color.withAlpha(40),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDisabled
                      ? Colors.grey.withAlpha(20)
                      : color.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isDisabled ? Colors.grey : color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDisabled ? Colors.grey : null,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDisabled
                          ? Colors.grey
                          : Theme.of(context).textTheme.bodySmall?.color,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çok Yakında'),
        content: const Text('Bu özellik çok yakında kullanıma sunulacaktır.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  /// Attempts to reconnect to the internet and navigate to the home page if successful.
  Future<void> _retryConnection(BuildContext context) async {
    final connectivityService = ConnectivityService();
    final hasConnection = await connectivityService.hasInternetConnection();

    if (!context.mounted) return;

    if (hasConnection) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('İnternet bağlantısı hala mevcut değil.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
