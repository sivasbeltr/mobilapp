/// Model for emergency contact information
class EmergencyContact {
  /// Name of the emergency service
  final String name;

  /// Phone number to call
  final String phoneNumber;

  /// Icon data for the contact
  final String iconName;

  /// Constructor for EmergencyContact
  const EmergencyContact({
    required this.name,
    required this.phoneNumber,
    required this.iconName,
  });
}

/// List of emergency contacts available offline
final List<EmergencyContact> emergencyContacts = [
  const EmergencyContact(
    name: 'Acil Çağrı',
    phoneNumber: '112',
    iconName: 'emergency',
  ),
  const EmergencyContact(name: 'İtfaiye', phoneNumber: '110', iconName: 'fire'),
  const EmergencyContact(name: 'Polis', phoneNumber: '155', iconName: 'police'),
  const EmergencyContact(
    name: 'Jandarma',
    phoneNumber: '156',
    iconName: 'gendarmerie',
  ),
  const EmergencyContact(
    name: 'Belediye',
    phoneNumber: '153',
    iconName: 'municipality',
  ),
  const EmergencyContact(
    name: 'AFAD',
    phoneNumber: '122',
    iconName: 'disaster',
  ),
];
