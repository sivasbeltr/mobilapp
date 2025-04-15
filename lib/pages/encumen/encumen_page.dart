import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../client/models/encumen_model.dart';
import '../../client/services/encumen_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/pages_app_bar.dart';
import '../show_image_full_page.dart';
import 'encumen_page_state.dart';

/// A page that displays the municipal committee members (Encümen).
class EncumenPage extends StatefulWidget {
  /// Creates a new [EncumenPage].
  const EncumenPage({Key? key}) : super(key: key);

  @override
  State<EncumenPage> createState() => _EncumenPageState();
}

class _EncumenPageState extends State<EncumenPage> {
  late final EncumenPageState _pageState;

  @override
  void initState() {
    super.initState();
    _pageState = EncumenPageState(
      service: EncumenService(),
    );
    _pageState.loadEncumen();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const PagesAppBar(
        title: 'Encümen',
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
                    onPressed: _pageState.loadEncumen,
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }

          if (_pageState.encumenMembers.isEmpty) {
            return Center(
              child: Text(
                'Encümen üyesi bulunamadı',
                style: theme.textTheme.titleMedium,
              ),
            );
          }

          return _buildMemberGrid(context);
        },
      ),
    );
  }

  /// Builds a grid of committee members with responsive layout
  Widget _buildMemberGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 600 ? 3 : 2;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _pageState.encumenMembers.length,
      itemBuilder: (context, index) {
        final member = _pageState.encumenMembers[index];
        return _EncumenMemberCard(member: member);
      },
    );
  }
}

/// A card widget that displays a committee member with portrait style
class _EncumenMemberCard extends StatelessWidget {
  final EncumenModel member;

  const _EncumenMemberCard({
    Key? key,
    required this.member,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Member photo with tap to enlarge
          Positioned.fill(
            child: InkWell(
              onTap: () => _openFullScreenImage(context),
              child: Hero(
                tag: 'encumen_${member.id}',
                child: member.photo != null
                    ? CachedNetworkImage(
                        imageUrl: member.photo!,
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
                      )
                    : Container(
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

          // Gradient overlay for text visibility
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withAlpha(220),
                    Colors.black.withAlpha(160),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.3, 0.9],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Member position/rank
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(160),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      member.rank,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Member name
                  Text(
                    member.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Opens the member's photo in full screen view
  void _openFullScreenImage(BuildContext context) {
    if (member.photo != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowImageFullPage(
            imageUrl: member.photo!,
            title: member.title,
          ),
        ),
      );
    }
  }
}
