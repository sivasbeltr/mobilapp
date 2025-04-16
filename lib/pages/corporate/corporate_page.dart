import 'package:flutter/material.dart';
import 'package:sivas_belediyesi/pages/corporate/detail/regulations/regulations_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/pages_app_bar.dart';
import '../contact/contact_page.dart';

/// A page that displays corporate structure information.
class CorporatePage extends StatelessWidget {
  /// Creates a [CorporatePage].
  const CorporatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const PagesAppBar(
        title: 'Kurumsal Yapı',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Elegant header with gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    isDark
                        ? AppColors.primary.withAlpha(180)
                        : AppColors.primaryLight,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(40),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                children: [
                  // Icon
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/belediye_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title
                  const Text(
                    'Kurumsal Yapı',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  Text(
                    'Sivas Belediyesi Kurumsal Bilgiler',
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // Corporate links section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Corporate links grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      _buildCorporateCard(
                        context: context,
                        title: 'Kurumsal Kimlik',
                        icon: Icons.badge_outlined,
                        color: const Color(0xFF1976D2),
                        onTap: () {},
                      ),
                      _buildCorporateCard(
                        context: context,
                        title: 'Bağlı Kuruluş ve İştirakler',
                        icon: Icons.account_tree_outlined,
                        color: const Color(0xFF388E3C),
                        url:
                            'https://www.sivas.bel.tr/sayfalar/bagli-kurulus-ve-istirakler',
                        onTap: () => _launchUrl(
                            'https://www.sivas.bel.tr/sayfalar/bagli-kurulus-ve-istirakler'),
                      ),
                      _buildCorporateCard(
                        context: context,
                        title: 'Belediye Mevzuat Sirküleri',
                        icon: Icons.gavel_outlined,
                        color: const Color(0xFF7B1FA2),
                        onTap: () {},
                      ),
                      _buildCorporateCard(
                        context: context,
                        title: 'Üyesi Olduğumuz Birlikler',
                        icon: Icons.groups_outlined,
                        color: const Color(0xFFE64A19),
                        onTap: () {},
                      ),
                      _buildCorporateCard(
                        context: context,
                        title: 'Yönetmelikler',
                        icon: Icons.menu_book_outlined,
                        color: const Color(0xFF0097A7),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegulationsPage()),
                          );
                        },
                      ),
                      _buildCorporateCard(
                        context: context,
                        title: 'Hesap Numaralarımız',
                        icon: Icons.account_balance_outlined,
                        color: const Color(0xFFD32F2F),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ContactPage()),
                          );
                        },
                      ),
                    ],
                  ),

                  // List-style links
                  const SizedBox(height: 16),
                  _buildListSectionTitle(context, 'Diğer Kurumsal Bilgiler'),
                  const SizedBox(height: 8),

                  _buildListItem(
                    context: context,
                    title: 'İç Kontrol',
                    icon: Icons.security_outlined,
                    color: const Color(0xFF5E35B1),
                    onTap: () {},
                  ),
                  _buildListItem(
                    context: context,
                    title: 'Formlar',
                    icon: Icons.description_outlined,
                    color: const Color(0xFF00897B),
                    onTap: () {},
                  ),
                  _buildListItem(
                    context: context,
                    title: 'Etik Komisyonu',
                    icon: Icons.balance_outlined,
                    color: const Color(0xFFC2185B),
                    onTap: () {},
                  ),
                  _buildListItem(
                    context: context,
                    title: 'Hizmet Standartlarımız',
                    icon: Icons.verified_outlined,
                    color: const Color(0xFF689F38),
                    onTap: () {},
                  ),
                  _buildListItem(
                    context: context,
                    title: 'Kalite Politikası',
                    icon: Icons.thumb_up_outlined,
                    color: const Color(0xFFEF6C00),
                    onTap: () {},
                    isLast: true,
                  ),
                ],
              ),
            ),

            // Footer info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: theme.colorScheme.surfaceVariant.withAlpha(100),
              child: Column(
                children: [
                  Text(
                    'Sivas Belediyesi',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sularbaşı, Atatürk Cad. No:3, 58040 Merkez/Sivas',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tel: 0346 221 01 10',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a grid card for corporate links
  Widget _buildCorporateCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    String? url,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? color.withAlpha(60) : color.withAlpha(30),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with gradient background
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color,
                      color.withAlpha(180),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: color.withAlpha(isDark ? 30 : 40),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(height: 12),
              // Title with optional URL indicator
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (url != null) ...[
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.link,
                      size: 12,
                      color: theme.colorScheme.primary.withAlpha(180),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Harici Bağlantı',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary.withAlpha(180),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a section title for list items
  Widget _buildListSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a list item for corporate links
  Widget _buildListItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: isDark ? theme.colorScheme.surface : theme.colorScheme.surface,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Icon with color background
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark ? color.withAlpha(30) : color.withAlpha(20),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Title
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  // Arrow icon
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: theme.colorScheme.onSurface.withAlpha(150),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isLast)
          Divider(
            indent: 56,
            height: 1,
            thickness: 1,
            color: theme.dividerTheme.color?.withAlpha(50),
          ),
      ],
    );
  }

  /// Launches a URL
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}
