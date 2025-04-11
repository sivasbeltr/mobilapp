/// Model for emergency procedures
class EmergencyProcedure {
  /// Type of emergency
  final EmergencyType type;

  /// Title of the procedure
  final String title;

  /// Steps to follow during this emergency
  final List<String> steps;

  /// Constructor for EmergencyProcedure
  const EmergencyProcedure({
    required this.type,
    required this.title,
    required this.steps,
  });
}

/// Type of emergency situation
enum EmergencyType { earthquake, fire, flood, trafficAccident }

/// Extension to get display names for emergency types
extension EmergencyTypeExtension on EmergencyType {
  String get displayName {
    switch (this) {
      case EmergencyType.earthquake:
        return 'Deprem';
      case EmergencyType.fire:
        return 'Yangın';
      case EmergencyType.flood:
        return 'Sel';
      case EmergencyType.trafficAccident:
        return 'Trafik Kazası';
    }
  }

  String get iconName {
    switch (this) {
      case EmergencyType.earthquake:
        return 'earthquake';
      case EmergencyType.fire:
        return 'fire';
      case EmergencyType.flood:
        return 'flood';
      case EmergencyType.trafficAccident:
        return 'car_crash';
    }
  }
}

/// List of emergency procedures available offline
final List<EmergencyProcedure> emergencyProcedures = [
  const EmergencyProcedure(
    type: EmergencyType.earthquake,
    title: 'Deprem Anında Yapılması Gerekenler',
    steps: [
      'Sakin kalın ve panik yapmayın.',
      'Çök-Kapan-Tutun hareketini yapın.',
      'Masa, sıra gibi eşyaların altına sığının.',
      'Pencere ve dış duvarlardan uzak durun.',
      'Deprem durduğunda binayı tahliye edin.',
      'Açık alanda toplanın.',
      'Artçı sarsıntılara karşı tetikte olun.',
      'Yetkililerin talimatlarını takip edin.',
    ],
  ),
  const EmergencyProcedure(
    type: EmergencyType.fire,
    title: 'Yangın Anında Yapılması Gerekenler',
    steps: [
      'İtfaiyeyi arayın (110).',
      'Yangın alarmını çalıştırın.',
      'Mümkünse yangın söndürücü kullanın.',
      'Yere yakın eğilerek hareket edin.',
      'Dumanın yayıldığı yönün tersine gidin.',
      'Sıcak kapı kollarına dokunmayın.',
      'Asansör kullanmayın.',
      'Acil çıkışlardan binayı tahliye edin.',
    ],
  ),
  const EmergencyProcedure(
    type: EmergencyType.flood,
    title: 'Sel Anında Yapılması Gerekenler',
    steps: [
      'Sel uyarılarını dinleyin ve takip edin.',
      'Yüksek noktalara çıkın.',
      'Elektrikli cihazlardan uzak durun.',
      'Sel sularında yürümeyin veya araç sürmeyin.',
      'Sel suyu ile temas eden yiyecekleri tüketmeyin.',
      'İçme suyunun temiz olduğundan emin olun.',
      'Yetkililerin talimatlarını bekleyin.',
      'Acil durum çantanızı hazır bulundurun.',
    ],
  ),
  const EmergencyProcedure(
    type: EmergencyType.trafficAccident,
    title: 'Trafik Kazası Anında Yapılması Gerekenler',
    steps: [
      'Aracınızı güvenli bir yere park edin ve motoru kapatın.',
      'Reflektör yerleştirin ve tehlike ışıklarını açın.',
      'Acil yardım hattını arayın (112).',
      'Yaralıları hareket ettirmeyin.',
      'İlk yardım bilginiz varsa uygulayın.',
      'Kazaya karışan araçların fotoğraflarını çekin.',
      'Araç bilgilerini ve sürücü bilgilerini alın.',
      'Trafik polisinin gelmesini bekleyin.',
    ],
  ),
];
