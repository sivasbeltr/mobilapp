import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html_unescape/html_unescape.dart';

import '../../../../client/models/department_detail_model.dart';
import '../../../show_image_full_page.dart';

/// A widget that displays the department manager's information
class PersonnelInfoWidget extends StatelessWidget {
  /// The department detail containing personnel information
  final DepartmentDetailModel department;

  /// Creates a [PersonnelInfoWidget]
  const PersonnelInfoWidget({
    Key? key,
    required this.department,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final personnel = department.personnel!;
    final unescape = HtmlUnescape();

    // Clean the HTML content by removing tags and unescaping HTML entities
    String cleanContent = _stripHtmlTags(personnel.content);
    cleanContent = unescape.convert(cleanContent);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Personnel info title
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Müdür Bilgileri',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          // Personnel info content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personnel photo
              if (department.photo != null) ...[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowImageFullPage(
                          imageUrl: department.photo!,
                          title: personnel.title,
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'department_photo_${department.id}',
                    child: Container(
                      width: 120,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withAlpha(40),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: department.photo!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: theme.colorScheme.surfaceVariant,
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: theme.colorScheme.surfaceVariant,
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: theme.colorScheme.primary.withAlpha(100),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],

              // Personnel information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      personnel.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Display the cleaned content
                    Text(
                      cleanContent,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Divider at bottom
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Divider(),
          ),
        ],
      ),
    );
  }

  /// Strip HTML tags from the given HTML string.
  String _stripHtmlTags(String htmlString) {
    final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    var result = htmlString.replaceAll(exp, ' ');
    result = result.replaceAll('&nbsp;', ' ');
    result = result.replaceAll('\n', ' ');
    result = result.replaceAll('\r', '');
    return result.replaceAll(RegExp(r' +'), ' ').trim();
  }
}
