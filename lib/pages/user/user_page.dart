import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/pages_app_bar.dart';

/// User profile page with aesthetically pleasing design.
class UserPage extends StatelessWidget {
  /// Creates a new [UserPage].
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const PagesAppBar(
        title: 'Profil',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header with gradient background
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                child: Column(
                  children: [
                    // Avatar with border
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(40),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: isDark
                            ? AppColors.surfaceDark
                            : AppColors.neutral100,
                        child: Icon(
                          Icons.person,
                          size: 58,
                          color: isDark
                              ? AppColors.primaryLight
                              : AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // User name
                    Text(
                      'Cihad GÜNDOĞDU',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // User status with verified badge
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.verified,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Doğrulanmış Kullanıcı',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // User stats section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(context, '7', 'Bildirim'),
                  _buildDivider(context),
                  _buildStatItem(context, '3', 'Talep'),
                  _buildDivider(context),
                  _buildStatItem(context, '12', 'İşlem'),
                ],
              ),
            ),

            const Divider(),

            // Account settings section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hesap Ayarları',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingsCard(
                    context: context,
                    icon: Icons.person_outline,
                    title: 'Kişisel Bilgiler',
                    subtitle: 'Ad, soyad ve iletişim bilgilerinizi düzenleyin',
                    color: AppColors.primary,
                  ),
                  _buildSettingsCard(
                    context: context,
                    icon: Icons.lock_outline,
                    title: 'Güvenlik',
                    subtitle:
                        'Şifrenizi değiştirin ve hesap güvenliğinizi artırın',
                    color: AppColors.secondary,
                  ),
                  _buildSettingsCard(
                    context: context,
                    icon: Icons.notifications_outlined,
                    title: 'Bildirim Ayarları',
                    subtitle: 'Bildirim tercihlerinizi yönetin',
                    color: Colors.amber.shade700,
                  ),
                ],
              ),
            ),

            const Divider(),

            // App preferences section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Uygulama Tercihleri',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingsItem(
                    context: context,
                    icon: Icons.language_outlined,
                    title: 'Dil',
                    trailing: 'Türkçe',
                  ),
                  _buildSettingsItem(
                    context: context,
                    icon: Icons.palette_outlined,
                    title: 'Tema',
                    trailing: isDark ? 'Koyu' : 'Açık',
                  ),
                  _buildSettingsItem(
                    context: context,
                    icon: Icons.notifications_active_outlined,
                    title: 'Bildirimler',
                    trailing: 'Açık',
                    showSwitch: true,
                  ),
                  _buildSettingsItem(
                    context: context,
                    icon: Icons.location_on_outlined,
                    title: 'Konum Hizmetleri',
                    trailing: 'Kapalı',
                    showSwitch: true,
                    switchValue: false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Logout button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.exit_to_app),
                label: const Text('Çıkış Yap'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),

            // Version info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Sivas Belediyesi Mobil Uygulaması v1.0.0',
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a stat item with number and label.
  Widget _buildStatItem(BuildContext context, String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  /// Builds a vertical divider for the stats section.
  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 40,
      width: 1,
      color: Theme.of(context).dividerColor,
    );
  }

  /// Builds a settings card with icon, title and subtitle.
  Widget _buildSettingsCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark ? color.withAlpha(40) : color.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.colorScheme.onSurface.withAlpha(150),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a settings item with icon, title and optional trailing content.
  Widget _buildSettingsItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String trailing,
    bool showSwitch = false,
    bool switchValue = true,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      leading: Icon(
        icon,
        color: theme.colorScheme.primary,
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium,
      ),
      trailing: showSwitch
          ? Switch(
              value: switchValue,
              onChanged: (value) {},
              activeColor: theme.colorScheme.primary,
            )
          : Text(
              trailing,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(150),
              ),
            ),
      onTap: () {},
    );
  }
}
