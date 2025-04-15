/// Model representing detailed information about a department
class DepartmentDetailModel {
  final int id;
  final String url;
  final String title;
  final String date;
  final String? mudTel;
  final String? mudDahili;
  final String? mudEmail;
  final String? datepicker;
  final String siteUrl;
  final String apiUrl;
  final String? otherUrl;
  final String? photo;
  final String? spot;
  final String? content;
  final Personnel? personnel;
  final List<dynamic>? images;
  final List<dynamic>? files;
  final List<Extra> extra;
  final List<Sublist> sublist;

  /// Get department manager's email from personnel contact info
  String? get email => personnel?.contact.isNotEmpty == true 
      ? personnel!.contact[2].eposta 
      : null;

  /// Get department phone number from personnel contact info
  String? get phone => personnel?.contact.isNotEmpty == true 
      ? personnel!.contact[0].phone 
      : null;

  /// Get department phone extension from personnel contact info
  String? get phoneExt => personnel?.contact.isNotEmpty == true 
      ? personnel!.contact[1].phoneExt 
      : null;

  DepartmentDetailModel({
    required this.id,
    required this.url,
    required this.title,
    required this.date,
    this.mudTel,
    this.mudDahili,
    this.mudEmail,
    this.datepicker,
    required this.siteUrl,
    required this.apiUrl,
    this.otherUrl,
    this.photo,
    this.spot,
    this.content,
    this.personnel,
    this.images,
    this.files,
    required this.extra,
    required this.sublist,
  });

  /// Factory constructor to create a DepartmentDetailModel from JSON
  factory DepartmentDetailModel.fromJson(Map<String, dynamic> json) {
    return DepartmentDetailModel(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      date: json['date'],
      mudTel: json['mud_tel'],
      mudDahili: json['mud_dahili'],
      mudEmail: json['mud_email'],
      datepicker: json['datepicker'],
      siteUrl: json['siteUrl'],
      apiUrl: json['apiUrl'],
      otherUrl: json['otherUrl'],
      photo: json['photo'],
      spot: json['spot'],
      content: json['content'],
      personnel: json['personnel'] != null
          ? Personnel.fromJson(json['personnel'])
          : null,
      images: json['images'],
      files: json['files'],
      extra: json['extra'] != null
          ? (json['extra'] as List).map((e) => Extra.fromJson(e)).toList()
          : [],
      sublist: json['sublist'] != null
          ? (json['sublist'] as List).map((e) => Sublist.fromJson(e)).toList()
          : [],
    );
  }

  /// Convert DepartmentDetailModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'date': date,
      'mud_tel': mudTel,
      'mud_dahili': mudDahili,
      'mud_email': mudEmail,
      'datepicker': datepicker,
      'siteUrl': siteUrl,
      'apiUrl': apiUrl,
      'otherUrl': otherUrl,
      'photo': photo,
      'spot': spot,
      'content': content,
      'personnel': personnel?.toJson(),
      'images': images,
      'files': files,
      'extra': extra.map((e) => e.toJson()).toList(),
      'sublist': sublist.map((e) => e.toJson()).toList(),
    };
  }
}

/// Model representing department personnel information
class Personnel {
  final String title;
  final String url;
  final String content;
  final List<Contact> contact;
  final List<Social> social;

  Personnel({
    required this.title,
    required this.url,
    required this.content,
    required this.contact,
    required this.social,
  });

  /// Factory constructor to create a Personnel from JSON
  factory Personnel.fromJson(Map<String, dynamic> json) {
    return Personnel(
      title: json['title'],
      url: json['url'],
      content: json['content'],
      contact: (json['contact'] as List)
          .map((e) => Contact.fromJson(e))
          .toList(),
      social: (json['social'] as List)
          .map((e) => Social.fromJson(e))
          .toList(),
    );
  }

  /// Convert Personnel to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'content': content,
      'contact': contact.map((e) => e.toJson()).toList(),
      'social': social.map((e) => e.toJson()).toList(),
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
    final Map<String, dynamic> data = {};
    if (phone != null) data['phone'] = phone;
    if (phoneExt != null) data['phone_ext'] = phoneExt;
    if (eposta != null) data['eposta'] = eposta;
    if (unitEposta != null) data['unit_eposta'] = unitEposta;
    if (fax != null) data['fax'] = fax;
    if (address != null) data['address'] = address;
    if (cord != null) data['cord'] = cord;
    if (build != null) data['build'] = build;
    return data;
  }
}

/// Model representing social media information
class Social {
  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? linkedin;
  final String? youtube;

  Social({
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
    this.youtube,
  });

  /// Factory constructor to create a Social from JSON
  factory Social.fromJson(Map<String, dynamic> json) {
    return Social(
      facebook: json['facebook'],
      twitter: json['twitter'],
      instagram: json['instagram'],
      linkedin: json['linkedin'],
      youtube: json['youtube'],
    );
  }

  /// Convert Social to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (facebook != null) data['facebook'] = facebook;
    if (twitter != null) data['twitter'] = twitter;
    if (instagram != null) data['instagram'] = instagram;
    if (linkedin != null) data['linkedin'] = linkedin;
    if (youtube != null) data['youtube'] = youtube;
    return data;
  }
}

/// Model representing extra fields
class Extra {
  final String? fieldFirst;
  final String? fieldSecond;
  final String? fieldThird;
  final String? fieldFourth;
  final String? fieldFifth;

  Extra({
    this.fieldFirst,
    this.fieldSecond,
    this.fieldThird,
    this.fieldFourth,
    this.fieldFifth,
  });

  /// Factory constructor to create an Extra from JSON
  factory Extra.fromJson(Map<String, dynamic> json) {
    return Extra(
      fieldFirst: json['field_first'],
      fieldSecond: json['field_second'],
      fieldThird: json['field_third'],
      fieldFourth: json['field_fourth'],
      fieldFifth: json['field_fifth'],
    );
  }

  /// Convert Extra to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (fieldFirst != null) data['field_first'] = fieldFirst;
    if (fieldSecond != null) data['field_second'] = fieldSecond;
    if (fieldThird != null) data['field_third'] = fieldThird;
    if (fieldFourth != null) data['field_fourth'] = fieldFourth;
    if (fieldFifth != null) data['field_fifth'] = fieldFifth;
    return data;
  }
}

/// Model representing sublist items (child pages)
class Sublist {
  final int id;
  final String title;
  final String url;
  final String siteUrl;
  final String apiUrl;
  final String? otherUrl;

  Sublist({
    required this.id,
    required this.title,
    required this.url,
    required this.siteUrl,
    required this.apiUrl,
    this.otherUrl,
  });

  /// Factory constructor to create a Sublist from JSON
  factory Sublist.fromJson(Map<String, dynamic> json) {
    return Sublist(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      siteUrl: json['siteUrl'],
      apiUrl: json['apiUrl'],
      otherUrl: json['otherUrl'],
    );
  }

  /// Convert Sublist to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'siteUrl': siteUrl,
      'apiUrl': apiUrl,
      'otherUrl': otherUrl,
    };
  }
}