class DeputyMayor {
  final int id;
  final String url;
  final String title;
  final String date;
  final String siteUrl;
  final String apiUrl;
  final String? otherUrl;
  final String photo;
  final String? spot;
  final List<Contact> contact;
  final List<Manager> managers;

  //add property managerCount
  int get managerCount => managers.length;
  //add property email and phone is contact first
  String? get email => contact.isNotEmpty ? contact[2].eposta : null;
  String? get phone => contact.isNotEmpty ? contact[0].phone : null;
  String? get phoneExt => contact.isNotEmpty ? contact[1].phoneExt : null;

  DeputyMayor({
    required this.id,
    required this.url,
    required this.title,
    required this.date,
    required this.siteUrl,
    required this.apiUrl,
    this.otherUrl,
    required this.photo,
    this.spot,
    required this.contact,
    required this.managers,
  });

  factory DeputyMayor.fromJson(Map<String, dynamic> json) {
    return DeputyMayor(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      date: json['date'],
      siteUrl: json['siteUrl'],
      apiUrl: json['apiUrl'],
      otherUrl: json['otherUrl'],
      photo: json['photo'],
      spot: json['spot'],
      contact: (json['contact'] as List)
          .map((item) => Contact.fromJson(item))
          .toList(),
      managers: (json['managers'] as List)
          .map((item) => Manager.fromJson(item))
          .toList(),
    );
  }
}

class Contact {
  final String? phone;
  final String? phoneExt;
  final String? eposta;
  final String? unitEposta;
  final String? fax;
  final String? address;
  final String? cord;
  final String? build;

  Contact({
    this.phone,
    this.phoneExt,
    this.eposta,
    this.unitEposta,
    this.fax,
    this.address,
    this.cord,
    this.build,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      phone: json['phone'],
      phoneExt: json['phone_ext'],
      eposta: json['eposta'],
      unitEposta: json['unit_eposta'],
      fax: json['fax'],
      address: json['address'],
      cord: json['cord'],
      build: json['build'],
    );
  }
}

class Manager {
  final int id;
  final String title;
  final String url;
  final String siteUrl;
  final String apiUrl;

  Manager({
    required this.id,
    required this.title,
    required this.url,
    required this.siteUrl,
    required this.apiUrl,
  });

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      siteUrl: json['siteUrl'],
      apiUrl: json['apiUrl'],
    );
  }
}
