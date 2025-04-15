/// Model representing detailed information about a Deputy Mayor
class DeputyMayorDetailModel {
  final int id;
  final String url;
  final String title;
  final String date;
  final String siteUrl;
  final String apiUrl;
  final String? otherUrl;
  final String photo;
  final String? spot;
  final String content;
  final List<Contact> contact;
  final List<Manager> managers;

  //add property managerCount
  int get managerCount => managers.length;
  //add property email and phone is contact first
  String? get email => contact.isNotEmpty ? contact[2].eposta : null;
  String? get phone => contact.isNotEmpty ? contact[0].phone : null;
  String? get phoneExt => contact.isNotEmpty ? contact[1].phoneExt : null;

  DeputyMayorDetailModel({
    required this.id,
    required this.url,
    required this.title,
    required this.date,
    required this.siteUrl,
    required this.apiUrl,
    this.otherUrl,
    required this.photo,
    this.spot,
    required this.content,
    required this.contact,
    required this.managers,
  });

  /// Factory constructor to create a DeputyMayorDetailModel from JSON
  factory DeputyMayorDetailModel.fromJson(Map<String, dynamic> json) {
    return DeputyMayorDetailModel(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      date: json['date'],
      siteUrl: json['siteUrl'],
      apiUrl: json['apiUrl'],
      otherUrl: json['otherUrl'],
      photo: json['photo'],
      spot: json['spot'],
      content: json['content'],
      contact: (json['contact'] as List<dynamic>)
          .map((e) => Contact.fromJson(e))
          .toList(),
      managers: (json['managers'] as List<dynamic>)
          .map((e) => Manager.fromJson(e))
          .toList(),
    );
  }

  /// Convert DeputyMayorDetailModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'date': date,
      'siteUrl': siteUrl,
      'apiUrl': apiUrl,
      'otherUrl': otherUrl,
      'photo': photo,
      'spot': spot,
      'content': content,
      'contact': contact.map((e) => e.toJson()).toList(),
      'managers': managers.map((e) => e.toJson()).toList(),
    };
  }
}

/// Model representing a contact detail
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

  /// Factory constructor to create a Contact from JSON
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

  /// Convert Contact to JSON
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'phone_ext': phoneExt,
      'eposta': eposta,
      'unit_eposta': unitEposta,
      'fax': fax,
      'address': address,
      'cord': cord,
      'build': build,
    };
  }
}

/// Model representing a manager
class Manager {
  final int id;
  final String title;
  final String url;
  final String siteUrl;
  final String apiUrl;
  final String photo;

  Manager({
    required this.id,
    required this.title,
    required this.url,
    required this.siteUrl,
    required this.apiUrl,
    required this.photo,
  });

  /// Factory constructor to create a Manager from JSON
  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      siteUrl: json['siteUrl'],
      apiUrl: json['apiUrl'],
      photo: json['photo'],
    );
  }

  /// Convert Manager to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'siteUrl': siteUrl,
      'apiUrl': apiUrl,
      'photo': photo,
    };
  }
}
