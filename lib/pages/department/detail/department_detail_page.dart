import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

import '../../../client/models/department_detail_model.dart';
import '../../../client/services/department_service.dart';
import '../../../core/widgets/pages_app_bar.dart';
import 'department_detail_page_state.dart';
import 'widgets/contact_info_widget.dart';
import 'widgets/department_header_widget.dart';
import 'widgets/personnel_info_widget.dart';
import 'widgets/sublist_info_widget.dart';

/// A page that displays detailed information about a department.
class DepartmentDetailPage extends StatefulWidget {
  /// The API URL to fetch the department details.
  final String apiUrl;

  /// Creates a [DepartmentDetailPage].
  const DepartmentDetailPage({
    Key? key,
    required this.apiUrl,
  }) : super(key: key);

  @override
  State<DepartmentDetailPage> createState() => _DepartmentDetailPageState();
}

class _DepartmentDetailPageState extends State<DepartmentDetailPage> {
  /// The state management object for this page.
  late final DepartmentDetailPageState _pageState;

  @override
  void initState() {
    super.initState();
    _pageState = DepartmentDetailPageState(
      service: DepartmentService(),
      apiUrl: widget.apiUrl,
    );
    _pageState.loadDepartmentDetail();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedBuilder(
          animation: _pageState,
          builder: (context, _) {
            return PagesAppBar(
              title: _pageState.departmentDetail?.title ?? 'Müdürlük Detayı',
            );
          },
        ),
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
            return _buildErrorView(context);
          }

          if (_pageState.departmentDetail == null) {
            return Center(
              child: Text(
                'Müdürlük bilgisi bulunamadı',
                style: theme.textTheme.titleMedium,
              ),
            );
          }

          final department = _pageState.departmentDetail!;

          return RefreshIndicator(
            onRefresh: _pageState.loadDepartmentDetail,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Department header with icon and title
                  DepartmentHeaderWidget(department: department),

                  // Content sections
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Personnel information
                        if (department.personnel != null) ...[
                          PersonnelInfoWidget(department: department),
                          const SizedBox(height: 20),
                        ],

                        // Sublist information (duties, regulations)
                        if (department.sublist.isNotEmpty) ...[
                          SublistInfoWidget(department: department),
                          const SizedBox(height: 20),
                        ],

                        // Contact information
                        if (department.personnel != null &&
                            (department.phone != null ||
                                department.email != null)) ...[
                          ContactInfoWidget(department: department),
                          const SizedBox(height: 20),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Builds an error view when data loading fails
  Widget _buildErrorView(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 48,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Veri yüklenirken bir hata oluştu',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _pageState.error ??
                  'Bilinmeyen bir hata oluştu. Lütfen tekrar deneyiniz.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _pageState.loadDepartmentDetail,
              icon: const Icon(Icons.refresh),
              label: const Text('Tekrar Dene'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
