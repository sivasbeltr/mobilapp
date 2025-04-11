import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget for displaying bank account information with a copy button
class BankAccountItem extends StatelessWidget {
  final String bankName;
  final String description;
  final String iban;

  const BankAccountItem({
    Key? key,
    required this.bankName,
    required this.description,
    required this.iban,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  bankName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => _copyToClipboard(context, iban),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isDarkMode
                        ? Colors.grey[800]
                        : Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      iban,
                      style: TextStyle(
                        fontFamily: 'Courier',
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.copy_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('IBAN numarası kopyalandı'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Tamam',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
