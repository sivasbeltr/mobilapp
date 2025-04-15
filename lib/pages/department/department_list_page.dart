import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../client/models/department_model.dart';
import '../../client/services/department_service.dart';
import '../../core/widgets/pages_app_bar.dart';
import 'department_list_page_state.dart';
import 'detail/department_detail_page.dart';

/// A page that displays a list of departments with search functionality.
class DepartmentListPage extends StatefulWidget {
  /// Creates a [DepartmentListPage].
  const DepartmentListPage({Key? key}) : super(key: key);

  @override
  State<DepartmentListPage> createState() => _DepartmentListPageState();
}

class _DepartmentListPageState extends State<DepartmentListPage> {
  /// The state management object for this page.
  late final DepartmentListPageState _pageState;

  /// Controller for the search text field.
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pageState = DepartmentListPageState(
      service: DepartmentService(),
    );
    _pageState.loadDepartments();

    _searchController.addListener(() {
      _pageState.filterDepartments(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const PagesAppBar(
        title: 'Müdürlükler',
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Müdürlük Ara...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                filled: true,
                fillColor: theme.colorScheme.surfaceVariant.withAlpha(100),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),

          // Department list
          Expanded(
            child: AnimatedBuilder(
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
                          onPressed: _pageState.loadDepartments,
                          child: const Text('Tekrar Dene'),
                        ),
                      ],
                    ),
                  );
                }

                if (_pageState.filteredDepartments.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: theme.colorScheme.primary.withAlpha(100),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchController.text.isNotEmpty
                              ? 'Aramanıza uygun müdürlük bulunamadı'
                              : 'Müdürlük bulunamadı',
                          style: theme.textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: _pageState.filteredDepartments.length,
                  itemBuilder: (context, index) {
                    final department = _pageState.filteredDepartments[index];
                    return DepartmentCard(
                      department: department,
                      onTap: () => _onDepartmentTap(department),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Handles tapping on a department card.
  void _onDepartmentTap(DepartmentModel department) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DepartmentDetailPage(
          apiUrl: department.apiUrl,
        ),
      ),
    );
  }
}

/// A card widget that displays information about a department.
class DepartmentCard extends StatelessWidget {
  /// The department to display.
  final DepartmentModel department;

  /// Callback when the card is tapped.
  final VoidCallback onTap;

  /// Creates a [DepartmentCard].
  const DepartmentCard({
    Key? key,
    required this.department,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.primary.withAlpha(30),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Department icon or placeholder
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withAlpha(120),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              const SizedBox(width: 16),

              // Department title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      department.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (department.spot != null &&
                        department.spot!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        department.spot!,
                        style: theme.textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Arrow icon
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A widget that displays HTML icon content.
class HtmlIconWidget extends StatelessWidget {
  /// The HTML icon string to display.
  final String htmlIcon;

  /// Creates a [HtmlIconWidget].
  const HtmlIconWidget({
    Key? key,
    required this.htmlIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // For simplicity, just extract the icon name from the HTML
    // This is a basic implementation and might need a more robust solution
    final iconNameRegex = RegExp(r'fa-([a-z-]+)');
    final match = iconNameRegex.firstMatch(htmlIcon);
    final iconName = match?.group(1) ?? 'building';

    // Map common icon names to MaterialIcons
    // This is a limited mapping that can be expanded as needed
    IconData iconData;
    switch (iconName) {
      case 'house-chimney-crack':
        iconData = Icons.home_work;
        break;
      case 'building':
        iconData = Icons.business;
        break;
      case 'city':
        iconData = Icons.location_city;
        break;
      case 'landmark':
        iconData = Icons.account_balance;
        break;
      case 'road':
        iconData = Icons.add_road;
        break;
      case 'tree':
        iconData = Icons.park;
        break;
      case 'water':
        iconData = Icons.water;
        break;
      case 'trash':
        iconData = Icons.delete;
        break;
      case 'bus':
        iconData = Icons.directions_bus;
        break;
      case 'users':
        iconData = Icons.people;
        break;
      case 'sack-dollar':
        iconData = Icons.attach_money;
        break;
      default:
        iconData = Icons.business;
        break;
    }

    return Icon(
      iconData,
      size: 28,
      color: theme.colorScheme.primary,
    );
  }
}
