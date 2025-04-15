import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../client/models/meclis_model.dart';
import '../../client/services/meclis_parti_service.dart';
import '../../client/services/meclis_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/pages_app_bar.dart';
import '../show_image_full_page.dart';
import 'meclis_page_state.dart';

/// A page that displays the municipal council members (Meclis) with filtering options.
class MeclisPage extends StatefulWidget {
  /// Creates a new [MeclisPage].
  const MeclisPage({Key? key}) : super(key: key);

  @override
  State<MeclisPage> createState() => _MeclisPageState();
}

class _MeclisPageState extends State<MeclisPage> {
  late final MeclisPageState _pageState;

  @override
  void initState() {
    super.initState();
    _pageState = MeclisPageState(
      service: MeclisService(),
      partyService: MeclisPartiService(),
    );
    _pageState.loadMeclis();
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
            return PagesAppBar(
              title: 'Belediye Meclisi',
              actions: [
                // Filter dropdown button
                PopupMenuButton<String>(
                  icon: const Icon(Icons.filter_list),
                  tooltip: 'Filtrele',
                  onSelected: (value) {
                    if (value == 'all') {
                      _pageState.clearPartyFilter();
                    } else if (value == 'group') {
                      _pageState.toggleGroupByParty();
                    } else {
                      _pageState.filterByParty(value);
                    }
                  },
                  itemBuilder: (context) {
                    final List<PopupMenuEntry<String>> items = [
                      const PopupMenuItem<String>(
                        value: 'all',
                        child: Text('Tümünü Göster'),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem<String>(
                        value: 'group',
                        child: Text('Partilere Göre Grupla'),
                      ),
                      const PopupMenuDivider(),
                    ];

                    // Add party filter options
                    for (final party in _pageState.parties) {
                      items.add(
                        PopupMenuItem<String>(
                          value: party.title,
                          child: Text(party.title),
                        ),
                      );
                    }

                    return items;
                  },
                ),
              ],
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
                    onPressed: _pageState.loadMeclis,
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }

          if (_pageState.displayedMembers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.filter_alt_off,
                    size: 64,
                    color: theme.colorScheme.onSurface.withAlpha(100),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Seçilen kriterlere uygun meclis üyesi bulunamadı',
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  if (_pageState.selectedParty != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: TextButton(
                        onPressed: () {
                          _pageState.clearPartyFilter();
                        },
                        child: const Text('Filtreyi Temizle'),
                      ),
                    ),
                ],
              ),
            );
          }

          return _pageState.isGroupedByParty
              ? _buildGroupedList()
              : _buildMemberGrid(context);
        },
      ),
    );
  }

  /// Builds a grouped list view of council members by party
  Widget _buildGroupedList() {
    final groupedMembers = _pageState.groupedMembers;
    final parties = groupedMembers.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: parties.length,
      itemBuilder: (context, index) {
        final party = parties[index];
        final members = groupedMembers[party] ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Party header
            Container(
              margin: EdgeInsets.only(bottom: 12, top: index > 0 ? 24 : 0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(40),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.group, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      party,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${members.length} Üye',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Members grid for this party
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: members.length,
              itemBuilder: (context, i) {
                final member = members[i];
                return _MeclisListItem(member: member);
              },
            ),
          ],
        );
      },
    );
  }

  /// Builds a grid of council members
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
      itemCount: _pageState.displayedMembers.length,
      itemBuilder: (context, index) {
        final member = _pageState.displayedMembers[index];
        return _MeclisListItem(member: member);
      },
    );
  }
}

/// A card widget that displays a council member with portrait style
class _MeclisListItem extends StatelessWidget {
  final MeclisModel member;

  const _MeclisListItem({
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
                tag: 'meclis_${member.id}',
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
                  // Party badge
                  if (member.party != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(160),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        member.party!,
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
