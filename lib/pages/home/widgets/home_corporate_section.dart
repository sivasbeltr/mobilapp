import 'package:flutter/material.dart';
import 'package:sivas_belediyesi/pages/meclis/meclis_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../department/department_list_page.dart';
import '../../deputy_mayor/deputy_mayor_list_page.dart';
import '../../encumen/encumen_page.dart';
import '../../mayor/mayor_page.dart';
import 'shared_section_styles.dart';

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
        route: '',
        color: const Color(0xFF1565C0), // Deep blue
        onTap: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MayorPage(),
            ),
          );
        },
      ),
      CorporateMenuItem(
        title: 'Belediye Meclisi',
        icon: Icons.groups,
        route: '',
        color: const Color(0xFF00838F), // Teal
        onTap: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MeclisPage(),
            ),
          );
        },
      ),
      CorporateMenuItem(
        title: 'Encümen',
        icon: Icons.groups,
        route: '',
        color: const Color(0xFF2E7D32), // Green
        onTap: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EncumenPage(),
            ),
          );
        },
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
        route: '',
        color: const Color(0xFF4527A0), // Deep purple
      )
    ];

    return SharedSectionContainer(
      title: 'Kurumsal',
      icon: Icons.business_center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.88,
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
    );
  }

  /// Builds a menu item with icon and label.
  Widget _buildMenuItem(
      BuildContext context, CorporateMenuItem item, bool isDark) {
    return SharedGridItem(
      icon: item.icon,
      title: item.title,
      color: item.color,
      onTap: () {
        if (item.onTap != null) {
          item.onTap!(context);
        } else if (item.route.isNotEmpty) {
          Navigator.of(context).pushNamed(item.route);
        }
      },
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
