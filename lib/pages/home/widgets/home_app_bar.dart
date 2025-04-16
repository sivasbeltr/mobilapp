import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../main.dart';
import '../../user/user_page.dart';

/// A clean AppBar for the home page with the Sivas Municipality logo and theme toggle.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a new [HomeAppBar].
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final isDarkTheme = themeProvider.isDarkTheme;

    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 4,
      centerTitle: false,
      title: Row(
        children: [
          // Logo image
          Image.asset(
            'assets/images/belediye_logo.png',
            height: 32,
            width: 32,
          ),
          const SizedBox(width: 8),
          // Municipality name
          const Text(
            'Sivas Belediyesi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        // User profile action
        IconButton(
          icon: const Icon(Icons.account_circle_outlined, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserPage()),
            );
          },
          tooltip: 'Profil',
        ),

        // Theme toggle action
        IconButton(
          icon: Icon(
            isDarkTheme ? Icons.light_mode : Icons.dark_mode,
            color: isDarkTheme ? Colors.amber : Colors.white,
          ),
          onPressed: themeProvider.toggleTheme,
          tooltip: isDarkTheme ? 'Açık Tema' : 'Koyu Tema',
        ),

        // Notifications action with badge
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.white),
              onPressed: () {
                // TODO: Implement notification page navigation
              },
              tooltip: 'Bildirimler',
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
