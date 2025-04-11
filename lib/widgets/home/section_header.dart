import 'package:flutter/material.dart';

/// Consistent section header for home page sections
class SectionHeader extends StatelessWidget {
  /// Title text to display
  final String title;

  /// Optional action button
  final Widget? action;

  const SectionHeader({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Accent line
          Container(
            height: 24,
            width: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          // Section title
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.titleLarge?.color,
                letterSpacing: 0.2,
              ),
            ),
          ),
          // Action button if provided
          if (action != null) action!,
        ],
      ),
    );
  }
}
