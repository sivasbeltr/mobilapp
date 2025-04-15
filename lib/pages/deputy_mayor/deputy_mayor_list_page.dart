import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../client/models/deputy_mayor_model.dart';
import '../../client/services/deputy_mayor_service.dart';
import '../../core/widgets/pages_app_bar.dart';
import 'detail/deputy_mayor_detail_page.dart';
import 'deputy_mayor_list_page_state.dart';

/// A page that displays a list of Deputy Mayors with their photos and information.
class DeputyMayorListPage extends StatefulWidget {
  /// Creates a [DeputyMayorListPage].
  const DeputyMayorListPage({Key? key}) : super(key: key);

  @override
  State<DeputyMayorListPage> createState() => _DeputyMayorListPageState();
}

class _DeputyMayorListPageState extends State<DeputyMayorListPage> {
  /// The state management object for this page.
  late final DeputyMayorListPageState _pageState;

  @override
  void initState() {
    super.initState();
    _pageState = DeputyMayorListPageState(
      service: DeputyMayorService(),
    );
    _pageState.loadDeputyMayors();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const PagesAppBar(
        title: 'Başkan Yardımcıları',
      ),
      body: AnimatedBuilder(
        animation: _pageState,
        builder: (context, _) {
          if (_pageState.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_pageState.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Veri yüklenirken bir hata oluştu',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _pageState.loadDeputyMayors,
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }

          if (_pageState.deputyMayors.isEmpty) {
            return Center(
              child: Text(
                'Başkan yardımcısı bulunamadı',
                style: theme.textTheme.titleMedium,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _pageState.deputyMayors.length,
            itemBuilder: (context, index) {
              final deputyMayor = _pageState.deputyMayors[index];
              return DeputyMayorCard(
                deputyMayor: deputyMayor,
                onTap: () => _onDeputyMayorTap(deputyMayor),
              );
            },
          );
        },
      ),
    );
  }

  /// Handles tapping on a deputy mayor card.
  void _onDeputyMayorTap(DeputyMayor deputyMayor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeputyMayorDetailPage(
          apiUrl: deputyMayor.apiUrl,
        ),
      ),
    );
  }
}

/// A card widget that displays information about a deputy mayor.
class DeputyMayorCard extends StatelessWidget {
  /// The deputy mayor to display.
  final DeputyMayor deputyMayor;

  /// Callback when the card is tapped.
  final VoidCallback onTap;

  /// Creates a [DeputyMayorCard].
  const DeputyMayorCard({
    Key? key,
    required this.deputyMayor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section with photo and info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side: Image
                Hero(
                  tag: 'deputy_mayor_${deputyMayor.id}',
                  child: Container(
                    width: 120,
                    height: 160,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withAlpha(40),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CachedNetworkImage(
                      imageUrl: deputyMayor.photo,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: theme.colorScheme.surfaceVariant,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: theme.colorScheme.surfaceVariant,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: theme.colorScheme.primary.withAlpha(100),
                        ),
                      ),
                    ),
                  ),
                ),

                // Right side: Information
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and title
                        Text(
                          deputyMayor.title,
                          style: theme.textTheme.titleLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        if (deputyMayor.spot != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            _truncateText(deputyMayor.spot!, 120),
                            style: theme.textTheme.bodyMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],

                        const SizedBox(height: 12),
                        const Divider(height: 1),
                        const SizedBox(height: 12),

                        // Contact information
                        if (deputyMayor.phone != null)
                          InkWell(
                            onTap: () => _makePhoneCall(deputyMayor.phone!),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 18,
                                    color: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          deputyMayor.phone!,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (deputyMayor.phoneExt != null)
                                          Text(
                                            'Dahili: ${deputyMayor.phoneExt}',
                                            style: theme.textTheme.bodySmall,
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        if (deputyMayor.email != null) ...[
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () => _sendEmail(deputyMayor.email!),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 18,
                                    color: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      deputyMayor.email!,
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Bottom row with unit count and detail button
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primaryContainer,
                    theme.colorScheme.primaryContainer.withAlpha(80),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.primary.withAlpha(30),
                    width: 1,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Managers count chip
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withAlpha(40),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: theme.colorScheme.primary.withAlpha(60),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${deputyMayor.managerCount} Birim',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Detail button
                  ElevatedButton.icon(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      minimumSize: const Size(40, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    label: const Text('Detay'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Launch phone call with the given number.
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await _launchUrl(launchUri);
  }

  /// Launch email with the given email address.
  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await _launchUrl(launchUri);
  }

  /// Launch a URL.
  Future<void> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  /// Truncates text to the specified length and adds ellipses if needed.
  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }
}
