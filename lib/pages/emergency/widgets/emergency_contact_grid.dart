import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Grid of emergency contact numbers
class EmergencyContactGrid extends StatelessWidget {
  /// Callback function when a contact is tapped
  final Function(String phoneNumber)? onTap;

  const EmergencyContactGrid({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.75,
      children: [
        _buildContactCard(
          context,
          title: 'Acil Çağrı Merkezi',
          phoneNumber: '112',
          icon: Icons.emergency,
        ),
        _buildContactCard(
          context,
          title: 'Polis İmdat',
          phoneNumber: '155',
          icon: Icons.local_police,
        ),
        _buildContactCard(
          context,
          title: 'Jandarma İmdat',
          phoneNumber: '156',
          icon: Icons.shield,
        ),
        _buildContactCard(
          context,
          title: 'İtfaiye',
          phoneNumber: '110',
          icon: Icons.fire_truck,
        ),
        _buildContactCard(
          context,
          title: 'AFAD',
          phoneNumber: '122',
          icon: Icons.support,
        ),
        _buildContactCard(
          context,
          title: 'Belediye',
          phoneNumber: '444 58 44',
          icon: Icons.location_city,
        ),
      ],
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required String title,
    required String phoneNumber,
    IconData icon = Icons.phone,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.neutral300, width: 1),
      ),
      child: InkWell(
        onTap: () => onTap?.call(phoneNumber),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                phoneNumber,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                      letterSpacing: 1.1,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
