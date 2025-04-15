import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../department/department_list_page.dart';
import '../../deputy_mayor/deputy_mayor_list_page.dart';

/// A widget that displays the corporate section on the home page.
class HomeCorporateSection extends StatelessWidget {
  /// Creates a new [HomeCorporateSection] widget.
  const HomeCorporateSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // List of corporate menu items
    final List<CorporateMenuItem> menuItems = [
      CorporateMenuItem(
        title: 'Başkanımız',
        icon: Icons.person,
        route: '/baskan',
        color: const Color(0xFF1565C0), // Deep blue
      ),
      CorporateMenuItem(
        title: 'Belediye Meclisi',
        icon: Icons.groups,
        route: '/meclis',
        color: const Color(0xFF00838F), // Teal
      ),
      CorporateMenuItem(
        title: 'Encümen',
        icon: Icons.group_work,
        route: '/encumen',
        color: const Color(0xFF2E7D32), // Green
      ),
      CorporateMenuItem(
        title: 'Başkan Yardımcıları',
        icon: Icons.people,
        route: '',
        color: const Color(0xFF6A1B9A), // Purple
        onTap: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DeputyMayorListPage(),
            ),
          );
        },
      ),
      CorporateMenuItem(
        title: 'Müdürlükler',
        icon: Icons.business,
        route: '',
        color: const Color(0xFFC62828), // Red
        onTap: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DepartmentListPage(),
            ),
          );
        },
      ),
      CorporateMenuItem(
        title: 'Organizasyon Şeması',
        icon: Icons.account_tree,
        route: '/organizasyon-semasi',
        color: const Color(0xFFEF6C00), // Orange
      ),
      CorporateMenuItem(
        title: 'Kurumsal Yapı',
        icon: Icons.domain,
        route: '/kurumsal-yapi',
        color: const Color(0xFF4527A0), // Deep purple
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Kurumsal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Grid of menu items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return _buildMenuItem(context, item, isDark);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a menu item with icon and label.
  Widget _buildMenuItem(
      BuildContext context, CorporateMenuItem item, bool isDark) {
    return Container(
      width: 70,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () {
          if (item.onTap != null) {
            item.onTap!(context);
          } else if (item.route.isNotEmpty) {
            Navigator.of(context).pushNamed(item.route);
          }
        },
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: item.color.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                size: 30,
                color: item.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

/// Model class for corporate menu items.
class CorporateMenuItem {
  final String title;
  final IconData icon;
  final String route;
  final Color color;
  final Function(BuildContext)? onTap;

  CorporateMenuItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.color,
    this.onTap,
  });
}
