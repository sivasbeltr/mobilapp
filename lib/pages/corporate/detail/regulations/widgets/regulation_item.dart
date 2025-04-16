import 'package:flutter/material.dart';
import '../models/regulation_model.dart';
import '../../../../../core/theme/app_colors.dart';

/// A widget that displays a regulation item with PDF link.
class RegulationItem extends StatelessWidget {
  /// The regulation data to display
  final RegulationModel regulation;

  /// Callback when the item is tapped
  final VoidCallback onTap;

  /// Creates a [RegulationItem].
  const RegulationItem({
    Key? key,
    required this.regulation,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Choose color based on category
    final Color categoryColor = _getCategoryColor(regulation.category);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark
              ? categoryColor.withAlpha(70)
              : categoryColor.withAlpha(40),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      categoryColor,
                      categoryColor.withAlpha(180),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  regulation.icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              // Title and category
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      regulation.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: categoryColor.withAlpha(isDark ? 40 : 25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            regulation.category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: categoryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Row(
                          children: [
                            Icon(
                              Icons.picture_as_pdf,
                              size: 14,
                              color: Colors.red,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'PDF',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Download icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(isDark ? 40 : 15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.download_rounded,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns a color based on the category.
  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'ulaşım':
        return Colors.blue;
      case 'çevre':
        return Colors.green;
      case 'güvenlik':
        return Colors.orange;
      case 'idari':
        return Colors.purple;
      case 'eğitim':
        return Colors.teal;
      case 'ticaret':
        return Colors.indigo;
      case 'gıda':
        return Colors.amber.shade800;
      default:
        return AppColors.primary;
    }
  }
}
