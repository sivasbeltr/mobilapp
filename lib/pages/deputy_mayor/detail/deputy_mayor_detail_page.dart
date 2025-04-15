import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../client/models/deputy_mayor_detail_model.dart';
import '../../../client/services/deputy_mayor_service.dart';
import '../../../core/widgets/pages_app_bar.dart';
import '../../show_image_full_page.dart';
import 'deputy_mayor_detail_page_state.dart';

/// A page that displays detailed information about a Deputy Mayor.
///
/// Navigates using the [apiUrl] parameter to fetch details.
class DeputyMayorDetailPage extends StatefulWidget {
  /// The API URL for fetching the deputy mayor's details.
  final String apiUrl;

  /// Creates a [DeputyMayorDetailPage].
  const DeputyMayorDetailPage({Key? key, required this.apiUrl})
      : super(key: key);

  @override
  State<DeputyMayorDetailPage> createState() => _DeputyMayorDetailPageState();
}

class _DeputyMayorDetailPageState extends State<DeputyMayorDetailPage> {
  late final DeputyMayorDetailPageState _pageState;

  @override
  void initState() {
    super.initState();
    _pageState = DeputyMayorDetailPageState(
      service: DeputyMayorService(),
      apiUrl: widget.apiUrl,
    );
    _pageState.loadDetail();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const PagesAppBar(title: 'Başkan Yardımcısı Detay'),
      body: AnimatedBuilder(
        animation: _pageState,
        builder: (context, _) {
          if (_pageState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_pageState.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      size: 48, color: theme.colorScheme.error),
                  const SizedBox(height: 16),
                  Text('Veri yüklenirken bir hata oluştu',
                      style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _pageState.loadDetail,
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }
          final detail = _pageState.detail;
          if (detail == null) {
            return const SizedBox();
          }
          // Clean HTML: Keep only <p> tags
          final cleanedContent =
              detail.content.replaceAll(RegExp(r'<(?!p|/p)[^>]+>'), '');

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo and info section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Photo with full-screen tap
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowImageFullPage(
                                imageUrl: detail.photo,
                                title: detail.title // Can be null
                                ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'deputy_photo_${detail.id}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: detail.photo,
                            width: 120,
                            height: 160,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 120,
                              height: 160,
                              color: theme.colorScheme.surfaceVariant,
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 120,
                              height: 160,
                              color: theme.colorScheme.surfaceVariant,
                              child: Icon(Icons.person,
                                  size: 60,
                                  color:
                                      theme.colorScheme.primary.withAlpha(100)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Name, title, and contact
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 16),
                          // Contact info
                          if (detail.contact.isNotEmpty)
                            _ContactInfoWidget(contact: detail.contact.first),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Content (cleaned HTML)
                Html(
                  data: cleanedContent,
                  style: {
                    'p': Style(
                      fontSize: FontSize.medium,
                      color: theme.colorScheme.onSurface,
                      lineHeight: const LineHeight(1.5),
                    ),
                  },
                ),
                const SizedBox(height: 24),
                // Managed departments
                if (detail.managers.isNotEmpty) ...[
                  Text(
                    'Bağlı Müdürlükler',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...detail.managers.map((m) => _ManagerInfoWidget(manager: m)),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Widget for displaying full-screen image
class _FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const _FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Hero(
          tag: 'deputy_photo_${imageUrl.hashCode}',
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) => const CircularProgressIndicator(
              color: Colors.white,
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: Colors.white,
              size: 48,
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget for displaying contact information
class _ContactInfoWidget extends StatelessWidget {
  final Contact contact;

  const _ContactInfoWidget({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Widget> rows = [];
    if ((contact.phone ?? '').isNotEmpty) {
      rows.add(
        GestureDetector(
          onTap: () async {
            final uri = Uri.parse('tel:${contact.phone}');
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          child: Row(
            children: [
              Icon(Icons.phone, size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                contact.phone!,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      );
    }
    if ((contact.eposta ?? '').isNotEmpty) {
      rows.add(
        GestureDetector(
          onTap: () async {
            final uri = Uri.parse('mailto:${contact.eposta}');
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          child: Row(
            children: [
              Icon(Icons.email, size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                contact.eposta!,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      );
    }
    if ((contact.address ?? '').isNotEmpty) {
      rows.add(
        Row(
          children: [
            Icon(Icons.location_on, size: 18, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                contact.address!,
                style: const TextStyle(),
              ),
            ),
          ],
        ),
      );
    }
    if (rows.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows
          .map((row) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: row,
              ))
          .toList(),
    );
  }
}

/// Widget for displaying manager (department) information
class _ManagerInfoWidget extends StatelessWidget {
  final Manager manager;

  const _ManagerInfoWidget({Key? key, required this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Optionally navigate to department detail
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: manager.photo,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 48,
                    height: 48,
                    color: theme.colorScheme.surfaceVariant,
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 48,
                    height: 48,
                    color: theme.colorScheme.surfaceVariant,
                    child: Icon(
                      Icons.business,
                      size: 28,
                      color: theme.colorScheme.primary.withAlpha(100),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  manager.title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
