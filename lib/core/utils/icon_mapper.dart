import 'package:flutter/material.dart';

/// Utility class to map string icon names to IconData
class IconMapper {
  /// Get icon data by name
  static IconData getIconData(String iconName) {
    switch (iconName) {
      case 'emergency':
        return Icons.emergency;
      case 'fire':
        return Icons.local_fire_department;
      case 'police':
        return Icons.local_police;
      case 'gendarmerie':
        return Icons.shield;
      case 'municipality':
        return Icons.location_city;
      case 'disaster':
        return Icons.warning_amber;
      case 'earthquake':
        return Icons.terrain;
      case 'flood':
        return Icons.water;
      case 'car_crash':
        return Icons.car_crash;
      default:
        return Icons.error;
    }
  }
}
