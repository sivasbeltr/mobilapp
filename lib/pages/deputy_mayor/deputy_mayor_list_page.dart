import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section on the left
            SizedBox(
              width: 120,
              height: 160,
              child: CachedNetworkImage(
                imageUrl: deputyMayor.photo,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: theme.colorScheme.primary.withAlpha(100),
                  ),
                ),
              ),
            ),

            // Information section on the right
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deputyMayor.title,
                      style: theme.textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      deputyMayor.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _truncateText(deputyMayor.spot ?? "", 120),
                      style: theme.textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: onTap,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          minimumSize: const Size(60, 36),
                        ),
                        child: const Text('Detay'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Truncates text to the specified length and adds ellipses if needed.
  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }
}
