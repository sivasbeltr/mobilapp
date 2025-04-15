import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';

/// A highly customizable and aesthetically pleasing AppBar for all pages
/// in the Sivas Municipality application.
///
/// This widget provides extensive customization options while maintaining
/// a consistent appearance across the app.
class PagesAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title to display in the AppBar
  final String title;

  /// Whether to show a back button
  final bool showBackButton;

  /// Whether to show the municipality logo
  final bool showLogo;

  /// Custom callback for the back button
  final VoidCallback? onBackPressed;

  /// Leading icon to show instead of the back button
  final IconData? leadingIcon;

  /// Custom callback for the leading icon
  final VoidCallback? onLeadingIconPressed;

  /// List of action widgets to display on the right side before the logo
  final List<Widget>? actions;

  /// Background color for the AppBar
  final Color? backgroundColor;

  /// Whether to use a gradient background
  final bool useGradientBackground;

  /// Whether to show an elevated effect
  final bool hasElevation;

  /// Custom elevation amount when hasElevation is true
  final double elevationValue;

  /// Whether to use a rounded bottom shape
  final bool useRoundedBottom;

  /// The radius value when useRoundedBottom is true
  final double roundedBottomRadius;

  /// Whether the title should be centered
  final bool centerTitle;

  /// Custom title style
  final TextStyle? titleStyle;

  /// Custom back icon
  final IconData backIcon;

  /// Status tag to show (e.g., "Offline")
  final String? statusTag;

  /// Status tag color
  final Color? statusTagColor;

  /// Status tag icon
  final IconData? statusTagIcon;

  /// Creates a new [PagesAppBar] with extensive customization options.
  const PagesAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.showLogo = true,
    this.onBackPressed,
    this.leadingIcon,
    this.onLeadingIconPressed,
    this.actions,
    this.backgroundColor,
    this.useGradientBackground = true,
    this.hasElevation = true,
    this.elevationValue = 4,
    this.useRoundedBottom = true,
    this.roundedBottomRadius = 16,
    this.centerTitle = false,
    this.titleStyle,
    this.backIcon = Icons.arrow_back_ios_rounded,
    this.statusTag,
    this.statusTagColor,
    this.statusTagIcon,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = backgroundColor ?? theme.primaryColor;
    final primaryDarker = HSLColor.fromColor(primaryColor)
        .withLightness((HSLColor.fromColor(primaryColor).lightness * 0.8))
        .toColor();
    final defaultTitleStyle = theme.textTheme.titleLarge?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );

    // Determine leading widget based on parameters
    Widget? leadingWidget;
    if (leadingIcon != null) {
      leadingWidget = IconButton(
        icon: Icon(leadingIcon),
        onPressed: onLeadingIconPressed,
      );
    } else if (showBackButton) {
      leadingWidget = IconButton(
        icon: Icon(backIcon, size: 22),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      );
    }

    // Compile action widgets
    final List<Widget> actionWidgets = [];

    // Add provided action widgets
    if (actions != null && actions!.isNotEmpty) {
      actionWidgets.addAll(actions!);
    }

    // Add status tag if provided
    if (statusTag != null) {
      actionWidgets.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: (statusTagColor ?? AppColors.error).withAlpha(30),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: (statusTagColor ?? AppColors.error).withAlpha(50),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (statusTagIcon != null) ...[
                Icon(
                  statusTagIcon,
                  color: statusTagColor ?? AppColors.error,
                  size: 14,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                statusTag!,
                style: TextStyle(
                  color: statusTagColor ?? AppColors.error,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Add municipality logo if requested
    if (showLogo) {
      actionWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white.withAlpha(40),
            ),
            child: Image.asset(
              'assets/images/belediye_logo.png',
              height: 38,
            ),
          ),
        ),
      );
    }

    return AppBar(
      leading: leadingWidget,
      automaticallyImplyLeading: false,
      backgroundColor: useGradientBackground
          ? null
          : primaryColor, // Gradient yoksa primaryColor uygula
      elevation: hasElevation ? elevationValue : 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      flexibleSpace: useGradientBackground
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primaryColor, primaryDarker],
                ),
              ),
            )
          : null,
      shape: useRoundedBottom
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(roundedBottomRadius),
              ),
            )
          : null,
      title: Text(
        title,
        style: titleStyle ?? defaultTitleStyle,
      ),
      centerTitle: centerTitle,
      actions: actionWidgets,
    );
  }
}
