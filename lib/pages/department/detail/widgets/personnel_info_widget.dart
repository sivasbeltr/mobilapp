import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';

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

    // Check if contact information is available
    final hasPhone = department.phone != null && department.phone!.isNotEmpty;
    final hasEmail = department.email != null && department.email!.isNotEmpty;
    final hasContactInfo = hasPhone || hasEmail;

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

          // Top row with two columns: image on left, contact info on right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEFT COLUMN: Personnel photo
              if (department.photo != null)
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

              // RIGHT COLUMN: Contact information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Personnel title
                    Text(
                      personnel.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Contact information section
                    if (hasContactInfo) ...[
                      if (hasPhone)
                        _buildContactItem(
                          context,
                          icon: Icons.phone,
                          title: 'Telefon',
                          value: department.phone!,
                          subtitle: department.phoneExt != null &&
                                  department.phoneExt!.isNotEmpty
                              ? 'Dahili: ${department.phoneExt}'
                              : null,
                          onTap: () => _makePhoneCall(department.phone!),
                        ),
                      if (hasPhone && hasEmail) const SizedBox(height: 8),
                      if (hasEmail)
                        _buildContactItem(
                          context,
                          icon: Icons.email,
                          title: 'E-posta',
                          value: department.email!,
                          onTap: () => _sendEmail(department.email!),
                        ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          // SECOND ROW: Description (full width)
          const SizedBox(height: 20),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              cleanContent,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
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

  /// Builds a contact item with icon, title and value
  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 16,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Launch phone call with the given number
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await _launchUrl(launchUri);
  }

  /// Launch email with the given email address
  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await _launchUrl(launchUri);
  }

  /// Launch a URL
  Future<void> _launchUrl(Uri url) async {
    try {
      await launchUrl(url);
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }
}
