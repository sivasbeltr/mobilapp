import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../client/services/connectivity_service.dart';
import '../../core/utils/navigation_service.dart';
import '../../core/widgets/base_page.dart';

/// Offline home page shown when there is no internet connection
class OfflineHomePage extends StatelessWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const OfflineHomePage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Sivas Belediyesi - Çevrimdışı',
      offlineAccessible: true,
      parameters: parameters,
      body: _buildOfflineContent(context),
      bottomNavigationBar: _buildRetryButton(context),
    );
  }

  Widget _buildOfflineContent(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
            const SizedBox(height: 24),
            Text(
              'İnternet Bağlantısı Yok',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'İnternet bağlantınız olmadığı için uygulamanın sınırlı özelliklerine erişebilirsiniz. Tam özellikler için lütfen internet bağlantınızı kontrol ediniz.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildOfflineFeatures(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOfflineFeatures(BuildContext context) {
    // List of features available offline
    final offlineFeatures = [
      {'title': 'Acil Numaralar', 'icon': Icons.phone},
      {'title': 'Kaydedilmiş Belgeler', 'icon': Icons.description},
      {'title': 'Çevrimdışı Harita', 'icon': Icons.map},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: offlineFeatures.length,
      itemBuilder: (context, index) {
        final feature = offlineFeatures[index];
        return _buildOfflineFeatureCard(
          context,
          title: feature['title'] as String,
          icon: feature['icon'] as IconData,
          onTap: () {
            // Navigate to offline feature
            // This would be implemented later
          },
        );
      },
    );
  }

  Widget _buildOfflineFeatureCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => _retryConnection(context),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Yeniden Bağlan'),
        ),
      ),
    );
  }

  Future<void> _retryConnection(BuildContext context) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Check connectivity
    final connectivityService = Provider.of<ConnectivityService>(
      context,
      listen: false,
    );
    final isConnected = await connectivityService.checkConnectivity();

    // Close loading dialog
    Navigator.pop(context);

    // Navigate based on connectivity
    if (isConnected) {
      NavigationService.replaceTo(NavigationService.home);
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'İnternet bağlantısı kurulamadı. Lütfen ağ ayarlarınızı kontrol ediniz.',
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
