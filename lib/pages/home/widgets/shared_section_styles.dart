import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// A shared container widget for home page sections with consistent styling.
class SharedSectionContainer extends StatelessWidget {
  /// Title of the section
  final String title;

  /// Optional icon to display with the title
  final IconData icon;

  /// Widget to display after the title
  final Widget? trailing;

  /// Child widget
  final Widget child;

  /// Creates a new [SharedSectionContainer].
  const SharedSectionContainer({
    Key? key,
    required this.title,
    required this.icon,
    this.trailing,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 6), // Reduced horizontal margin
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              isDark ? Colors.white.withAlpha(15) : Colors.black.withAlpha(10),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withAlpha(40)
                : Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enhanced header with gradient border
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? Colors.white.withAlpha(15)
                      : Colors.black.withAlpha(10),
                  width: 1,
                ),
              ),
            ),
            padding:
                const EdgeInsets.fromLTRB(14, 14, 14, 10), // Reduced padding
            child: Row(
              children: [
                // Section icon with gradient background
                Container(
                  padding: const EdgeInsets.all(6), // Reduced padding
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withAlpha(180),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10), // Reduced spacing
                // Section title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),

                const Spacer(),

                // Optional trailing widget
                if (trailing != null) trailing!,
              ],
            ),
          ),

          // Content with reduced padding
          Padding(
            padding: const EdgeInsets.all(8), // Reduced padding
            child: child,
          ),
        ],
      ),
    );
  }
}

/// A shared grid item widget with consistent styling for grid layouts.
class SharedGridItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const SharedGridItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10), // Reduced border radius
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10), // Reduced border radius
        splashColor: color.withAlpha(40),
        highlightColor: color.withAlpha(20),
        child: Ink(
          decoration: BoxDecoration(
            color: isDark ? color.withAlpha(25) : color.withAlpha(15),
            borderRadius: BorderRadius.circular(10), // Reduced border radius
            border: Border.all(
              color: color.withAlpha(isDark ? 40 : 30),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Fixed height for top padding
              const SizedBox(height: 8), // Reduced spacing

              // Icon with gradient - in a fixed position
              Container(
                width: 44, // Reduced size
                height: 44, // Reduced size
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color,
                      color.withAlpha(180),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withAlpha(50),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 22, // Reduced size
                ),
              ),

              // Fixed height spacing
              const SizedBox(height: 8), // Reduced spacing

              // Title with fixed height container
              Container(
                height: 32, // Reduced height for text area
                alignment: Alignment.center, // Center the text vertically
                padding: const EdgeInsets.symmetric(
                    horizontal: 2.0), // Reduced padding
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 11, // Reduced font size
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A shared circular item widget with consistent styling for horizontal lists.
class SharedCircularItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const SharedCircularItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      width: 65,
      child: Column(
        children: [
          // Circular icon button
          Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              splashColor: color.withAlpha(40),
              highlightColor: color.withAlpha(20),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color,
                      color.withAlpha(180),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withAlpha(50),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4), // Alt boşluk 6'dan 4'e düşürüldü
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
