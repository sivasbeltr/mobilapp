import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../client/models/emergency_contact.dart';
import '../../client/models/emergency_procedure.dart';
import '../../client/services/connectivity_service.dart';
import '../../core/utils/navigation_service.dart';
import '../../core/widgets/base_page.dart';
import '../../widgets/emergency/emergency_contact_card.dart';
import '../../widgets/emergency/emergency_procedure_card.dart';

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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConnectionStatusBanner(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Acil Durum Numaraları'),
            const SizedBox(height: 8),
            _buildEmergencyContactsGrid(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Acil Durumlarda Yapılması Gerekenler'),
            const SizedBox(height: 8),
            _buildEmergencyProceduresList(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionStatusBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.error,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_off, color: Colors.grey, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'İnternet Bağlantısı Yok',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Acil durum bilgilerine ve numaralarına çevrimdışı erişebilirsiniz.',
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
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildEmergencyContactsGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: emergencyContacts.length,
      itemBuilder: (context, index) {
        final contact = emergencyContacts[index];
        return EmergencyContactCard(contact: contact);
      },
    );
  }

  Widget _buildEmergencyProceduresList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: emergencyProcedures.length,
      itemBuilder: (context, index) {
        final procedure = emergencyProcedures[index];
        return EmergencyProcedureCard(procedure: procedure);
      },
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
