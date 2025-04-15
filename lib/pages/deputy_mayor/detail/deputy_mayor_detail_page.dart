import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../client/models/deputy_mayor_detail_model.dart';
import '../../../client/services/deputy_mayor_service.dart';
import '../../../core/widgets/pages_app_bar.dart';
import '../../department/detail/department_detail_page.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedBuilder(
          animation: _pageState,
          builder: (context, _) {
            final detail = _pageState.detail;
            return PagesAppBar(
              title: detail?.title ?? 'Başkan Yardımcısı Detay',
            );
          },
        ),
      ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enhanced photo and info section
                _buildHeaderSection(context, detail),

                // Content (cleaned HTML)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Html(
                    data: cleanedContent,
                    style: {
                      'p': Style(
                        fontSize: FontSize.medium,
                        color: theme.colorScheme.onSurface,
                        lineHeight: const LineHeight(1.5),
                        margin: Margins.only(bottom: 16),
                      ),
                    },
                  ),
                ),

                // Enhanced managed departments section
                if (detail.managers.isNotEmpty)
                  _buildManagedDepartmentsSection(context, detail.managers),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds the enhanced header section with photo and contact information
  Widget _buildHeaderSection(
      BuildContext context, DeputyMayorDetailModel detail) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primaryContainer.withAlpha(50),
      child: Column(
        children: [
          // Top section with image and basic info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enhanced photo with shadow and border
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowImageFullPage(
                          imageUrl: detail.photo,
                          title: detail.title,
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'deputy_photo_${detail.id}',
                    child: Container(
                      width: 130,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withAlpha(40),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: detail.photo,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: theme.colorScheme.surfaceVariant,
                            child: const Center(
                                child: CircularProgressIndicator()),
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
                  ),
                ),

                const SizedBox(width: 16),

                // Enhanced name, title, and contact
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Enhanced contact info
                      _ContactInfoWidget(detail: detail),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom decoration bar
          Container(
            height: 6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withAlpha(120),
                  theme.colorScheme.primary.withAlpha(0),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the enhanced managed departments section as a vertical list
  Widget _buildManagedDepartmentsSection(
      BuildContext context, List<Manager> managers) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 16),
      color: theme.colorScheme.surfaceVariant.withAlpha(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                Icon(
                  Icons.business,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Bağlı Müdürlükler',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          // Manager items in a vertical list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemCount: managers.length,
            itemBuilder: (context, index) {
              return _ManagerListItemWidget(manager: managers[index]);
            },
          ),
        ],
      ),
    );
  }
}

/// Widget for displaying contact information
class _ContactInfoWidget extends StatelessWidget {
  final DeputyMayorDetailModel detail;

  const _ContactInfoWidget({required this.detail});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Widget> rows = [];

    if ((detail.phone ?? '').isNotEmpty) {
      rows.add(
        InkWell(
          onTap: () async {
            final uri = Uri.parse('tel:${detail.phone}');
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.phone,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Telefon',
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        detail.phone!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      if (detail.phoneExt != null)
                        Text(
                          'Dahili: ${detail.phoneExt}',
                          style: theme.textTheme.bodySmall,
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

    if ((detail.email ?? '').isNotEmpty) {
      rows.add(
        InkWell(
          onTap: () async {
            final uri = Uri.parse('mailto:${detail.email}');
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.email,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'E-posta',
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        detail.email!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.primary,
                        ),
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

/// Widget for displaying a manager (department) as a list item
class _ManagerListItemWidget extends StatelessWidget {
  final Manager manager;

  const _ManagerListItemWidget({required this.manager});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DepartmentDetailPage(apiUrl: manager.apiUrl),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Small portrait image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 60,
                height: 80,
                child: CachedNetworkImage(
                  imageUrl: manager.photo,
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
                      Icons.business,
                      size: 30,
                      color: theme.colorScheme.primary.withAlpha(100),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Department title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    manager.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
