import 'package:flutter/material.dart';

/// Widget for selecting issue categories
class CategorySelector extends StatelessWidget {
  /// List of categories to display
  final List<Map<String, dynamic>> categories;

  /// Currently selected category ID
  final String? selectedCategory;

  /// Callback when a category is selected
  final Function(String) onCategorySelected;

  const CategorySelector({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? Theme.of(context).cardTheme.color : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13), // Changed from withOpacity(0.05)
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _buildEnhancedCategoryItem(context, category),
                );
              }).toList(),
            ),
          ),
          // Small indicator dots to show scroll position
          if (categories.length > 4)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 18,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      )
                          .colorScheme
                          .primary
                          .withAlpha(153), // Changed from withOpacity(0.6)
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// Enhanced category item with better visual styling
  Widget _buildEnhancedCategoryItem(
    BuildContext context,
    Map<String, dynamic> category,
  ) {
    final isSelected = category['id'] == selectedCategory;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.primary
            : isDarkMode
                ? theme.cardTheme.color
                    ?.withAlpha(179) // Changed from withOpacity(0.7)
                : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.primary
                  .withAlpha(38), // Changed from withOpacity(0.15)
          width: isSelected ? 2 : 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: theme.colorScheme.primary
                      .withAlpha(77), // Changed from withOpacity(0.3)
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                  spreadRadius: 0.5,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onCategorySelected(category['id'] as String),
          borderRadius: BorderRadius.circular(11),
          splashColor: theme.colorScheme.primary
              .withAlpha(26), // Changed from withOpacity(0.1)
          highlightColor: theme.colorScheme.primary
              .withAlpha(13), // Changed from withOpacity(0.05)
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white
                            .withAlpha(77) // Changed from withOpacity(0.3)
                        : theme.colorScheme.primary
                            .withAlpha(26), // Changed from withOpacity(0.1)
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    category['icon'] as IconData,
                    color:
                        isSelected ? Colors.white : theme.colorScheme.primary,
                    size: 17,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  category['name'] as String,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : isDarkMode
                            ? Colors.white
                            : theme.textTheme.bodyMedium?.color,
                    fontSize: 13.5,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
