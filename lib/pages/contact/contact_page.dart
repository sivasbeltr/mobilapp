import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/widgets/pages_app_bar.dart';
import 'widgets/bank_account_item.dart';
import 'widgets/contact_header.dart';
import 'widgets/contact_item.dart';

/// Contact information for the municipality
class ContactPage extends StatefulWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const ContactPage({super.key, this.parameters});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PagesAppBar(
        title: 'İletişim',
        showBackButton: true,
        showLogo: true,
        hasElevation: true,
        elevationValue: 3,
        useRoundedBottom: false,
        useGradientBackground: false,
        backIcon: Icons.arrow_back_ios_rounded,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Elegant compact header
            const ContactHeader(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address and Contact Info Card
                  _buildSectionCard(
                    context,
                    title: 'İletişim Bilgileri',
                    icon: Icons.contact_phone,
                    children: [
                      ContactItem(
                        icon: Icons.location_on,
                        title: 'Adres',
                        content:
                            'Sularbaşı, Atatürk Cad. No:3, 58040 Merkez/Sivas',
                        onTap: () => _openMaps('Sivas Belediyesi'),
                        iconColor: Colors.red,
                      ),
                      _buildDivider(),
                      ContactItem(
                        icon: Icons.phone,
                        title: 'Telefon',
                        content: '0346 221 01 10',
                        onTap: () => _makePhoneCall('03462210110'),
                        iconColor: Colors.green,
                      ),
                      _buildDivider(),
                      ContactItem(
                        icon: Icons.call,
                        title: 'Çağrı Merkezi',
                        content: '444 58 44',
                        onTap: () => _makePhoneCall('4445844'),
                        iconColor: Colors.blue,
                      ),
                      _buildDivider(),
                      ContactItem(
                        icon: Icons.email,
                        title: 'E-Posta',
                        content: 'bilgi@sivas.bel.tr',
                        onTap: () => _sendEmail('bilgi@sivas.bel.tr'),
                        iconColor: Colors.orange,
                      ),
                      _buildDivider(),
                      ContactItem(
                        icon: Icons.message,
                        title: 'WhatsApp İhbar Hattı',
                        content: '0532 219 58 58',
                        onTap: () => _openWhatsApp('05322195858'),
                        iconColor: const Color(0xFF25D366),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Bank Account Info Card
                  _buildSectionCard(
                    context,
                    title: 'Banka Hesap Bilgileri',
                    icon: Icons.account_balance,
                    children: [
                      // Tax info
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.amber.withAlpha(25),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.receipt_long,
                                color: Colors.amber,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vergi Dairesi ve Numarası',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey[300]
                                        : Colors.grey[600],
                                  ),
                                ),
                                const Text(
                                  'Kale VD. 771 00 50 652',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      _buildDivider(),

                      // Bank accounts with copy buttons
                      const BankAccountItem(
                        bankName: 'Ziraat Bankası',
                        description: 'Su borcu ödemeleri hariç tüm ödemeler',
                        iban: 'TR80 0001 0002 3036 9170 9950 01',
                      ),
                      _buildDivider(),
                      const BankAccountItem(
                        bankName: 'Vakıflar Bankası',
                        description: 'Su tahsilatı için',
                        iban: 'TR71 0001 5001 5800 7282 5729 09',
                      ),
                      _buildDivider(),
                      const BankAccountItem(
                        bankName: 'Vakıflar Bankası',
                        description: 'Diğer ödemeler için',
                        iban: 'TR69 0001 5001 5800 7293 4785 58',
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Working Hours Card
                  _buildSectionCard(
                    context,
                    title: 'Çalışma Saatleri',
                    icon: Icons.access_time_filled,
                    children: [
                      _buildWorkingHoursRow(
                        context,
                        'Pazartesi - Cuma',
                        '08:00 - 17:00',
                        active: true,
                      ),
                      _buildDivider(),
                      _buildWorkingHoursRow(
                        context,
                        'Cumartesi - Pazar',
                        'Kapalı',
                        active: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]!
              : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Theme.of(context).colorScheme.primary.withAlpha(25),
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildWorkingHoursRow(
    BuildContext context,
    String days,
    String hours, {
    required bool active,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (active ? Colors.green : Colors.grey).withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              active ? Icons.check_circle : Icons.cancel,
              color: active ? Colors.green : Colors.grey,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  days,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hours,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[300]
                        : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 8,
      endIndent: 8,
      color: Colors.grey.withAlpha(38),
    );
  }

  // Updated URL launcher methods to ensure they work properly

  // Open maps with properly encoded URL
  Future<void> _openMaps(String destination) async {
    final encodedDest = Uri.encodeComponent(destination);
    final mapUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$encodedDest,Sivas,Turkey',
    );

    try {
      if (await canLaunchUrl(mapUrl)) {
        await launchUrl(mapUrl, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar('Harita uygulaması açılamadı');
      }
    } catch (e) {
      _showErrorSnackBar('Hata: $e');
    }
  }

  // Make phone call with proper error handling
  Future<void> _makePhoneCall(String phoneNumber) async {
    // Remove any non-digit characters
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    final telUri = Uri.parse('tel:$cleanNumber');

    try {
      if (await canLaunchUrl(telUri)) {
        await launchUrl(telUri);
      } else {
        _showErrorSnackBar('Telefon uygulaması açılamadı');
      }
    } catch (e) {
      _showErrorSnackBar('Hata: $e');
    }
  }

  // Send email with proper error handling
  Future<void> _sendEmail(String email) async {
    final emailUri = Uri.parse('mailto:$email?subject=İletişim');

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _showErrorSnackBar('E-posta uygulaması açılamadı');
      }
    } catch (e) {
      _showErrorSnackBar('Hata: $e');
    }
  }

  // Open WhatsApp with proper error handling
  Future<void> _openWhatsApp(String phoneNumber) async {
    // Remove any non-digit characters
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    final whatsappUrl = Uri.parse('https://wa.me/+90$cleanNumber');

    try {
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar('WhatsApp açılamadı');
      }
    } catch (e) {
      _showErrorSnackBar('Hata: $e');
    }
  }

  // Show error message
  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
