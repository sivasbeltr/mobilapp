import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// The header section of the emergency page with warning message
class EmergencyHeader extends StatelessWidget {
  const EmergencyHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.secondary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Emergency icon - animation removed
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.warning_rounded,
              color: AppColors.secondary,
              size: 36,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'ACİL DURUM',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'Bu sayfadaki bilgiler acil bir durumda size yardımcı olabilir. Lütfen gerektiğinde kullanmak için bu sayfayı inceleyin.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withAlpha(240),
                ),
          ),
        ],
      ),
    );
  }
}
