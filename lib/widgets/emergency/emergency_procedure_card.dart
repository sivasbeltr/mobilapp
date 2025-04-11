import 'package:flutter/material.dart';

import '../../client/models/emergency_procedure.dart';
import '../../core/utils/icon_mapper.dart';

/// A card widget for displaying emergency procedures
class EmergencyProcedureCard extends StatelessWidget {
  /// Procedure information to display
  final EmergencyProcedure procedure;

  /// Constructor for EmergencyProcedureCard
  const EmergencyProcedureCard({required this.procedure, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ExpansionTile(
        leading: Icon(
          IconMapper.getIconData(procedure.type.iconName),
          color: _getEmergencyColor(procedure.type, context),
        ),
        title: Text(
          procedure.type.displayName,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          procedure.title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < procedure.steps.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${i + 1}. ',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            procedure.steps[i],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Returns a color based on the type of emergency
  Color _getEmergencyColor(EmergencyType type, BuildContext context) {
    switch (type) {
      case EmergencyType.earthquake:
        return Colors.orange;
      case EmergencyType.fire:
        return Colors.red;
      case EmergencyType.flood:
        return Colors.blue;
      case EmergencyType.trafficAccident:
        return Colors.amber;
    }
  }
}
