import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../client/services/connectivity_service.dart';
import '../../core/utils/navigation_service.dart';

/// Standalone offline home page shown when there is no internet connection
class OfflineHomePage extends StatelessWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const OfflineHomePage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom AppBar with logo
          _buildCustomAppBar(context),

          // Connection status banner
          _buildConnectionStatusBanner(context),

          // Offline accessible pages
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(
                    context,
                    'Çevrimdışı Kullanılabilir Sayfalar',
                  ),
                  const SizedBox(height: 20),

                  // Offline pages grid - just two pages
                  _buildOfflinePagesGrid(context),

                  const Spacer(),

                  // Try reconnecting button at the bottom
                  _buildRetryButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 16,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Municipality Logo with circular background
          Container(
            height: 42,
            width: 42,
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
            padding: const EdgeInsets.all(6),
            child: Image.asset(
              'assets/images/belediye_logo.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          // City name and municipality text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'SİVAS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),
              Text(
                'BELEDİYESİ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Dark mode toggle
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.brightness_6,
                color: Colors.white,
                size: 22,
              ),
              onPressed: () {
                // Toggle dark mode
                // This would depend on your theme provider implementation
              },
              tooltip: 'Tema Değiştir',
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionStatusBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: Theme.of(context).colorScheme.error.withOpacity(0.1),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.wifi_off, color: Colors.grey, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'İnternet Bağlantısı Yok',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Sadece çevrimdışı içeriğe erişilebilir',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 24,
              width: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Divider(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          height: 16,
        ),
      ],
    );
  }

  Widget _buildOfflinePagesGrid(BuildContext context) {
    // Only 2 offline pages
    final List<Map<String, dynamic>> offlinePages = [
      {
        'title': 'Acil Durumlar',
        'icon': Icons.emergency_outlined,
        'description': 'Acil durum bilgileri ve önemli telefon numaraları',
        'gradient': const LinearGradient(
          colors: [Color(0xFFE74C3C), Color(0xFFFF5E57)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': NavigationService.emergency,
      },
      {
        'title': 'İletişim',
        'icon': Icons.contact_phone,
        'description': 'Belediye iletişim bilgileri',
        'gradient': const LinearGradient(
          colors: [Color(0xFF9B59B6), Color(0xFFA569BD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'route': NavigationService.contact,
      },
    ];

    return Center(
      child: Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.center,
        children:
            offlinePages.map((pageData) {
              return _buildOfflinePageCard(context, pageData);
            }).toList(),
      ),
    );
  }

  Widget _buildOfflinePageCard(
    BuildContext context,
    Map<String, dynamic> pageData,
  ) {
    return InkWell(
      onTap: () => NavigationService.navigateTo(pageData['route']),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 150,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: (pageData['gradient'] as LinearGradient).colors.first
                  .withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Background gradient
              Container(
                decoration: BoxDecoration(gradient: pageData['gradient']),
              ),

              // Subtle pattern overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon in circular background
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        pageData['icon'],
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      pageData['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Description
                    Text(
                      pageData['description'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _retryConnection(context),
        icon: const Icon(Icons.refresh),
        label: const Text('İnternet Bağlantısını Kontrol Et'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
