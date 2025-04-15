/// Model representing a collection of photos and content selected from the mayor.
class MayorSelectionModel {
  /// Unique identifier
  final int id;

  /// URL slug
  final String url;

  /// Title of the selection
  final String title;

  /// Date information (usually relative format like "1 ay önce")
  final String date;

  /// Optional date update information
  final String? dateUpdate;

  /// Optional datepicker value
  final String? datepicker;

  /// Optional bookmark count or identifier
  final int? bookmark;

  /// Website URL for this content
  final String? siteUrl;

  /// API URL for fetching this content
  final String? apiUrl;

  /// Optional alternative URL
  final String? otherUrl;

  /// Main photo URL for this selection
  final String? photo;

  /// Optional short description
  final String? spot;

  /// Optional detailed content
  final String? content;

  /// Extra fields associated with the content
  final List<Map<String, String>> extra;

  /// Collection of images associated with the mayor
  final List<MayorSelectionImage> images;

  /// Optional files associated with the content
  final List<dynamic>? files;

  /// Creates a new [MayorSelectionModel] instance.
  MayorSelectionModel({
    required this.id,
    required this.url,
    required this.title,
    required this.date,
    this.dateUpdate,
    this.datepicker,
    this.bookmark,
    this.siteUrl,
    this.apiUrl,
    this.otherUrl,
    this.photo,
    this.spot,
    this.content,
    required this.extra,
    required this.images,
    this.files,
  });

  /// Creates a [MayorSelectionModel] from JSON data.
  factory MayorSelectionModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, String>> extraList = [];
    if (json['extra'] != null) {
      for (var item in json['extra']) {
        extraList.add(Map<String, String>.from(item));
      }
    }

    List<MayorSelectionImage> imagesList = [];
    if (json['images'] != null) {
      for (var item in json['images']) {
        imagesList.add(MayorSelectionImage.fromJson(item));
      }
    }

    return MayorSelectionModel(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      date: json['date'],
      dateUpdate: json['dateUpdate'],
      datepicker: json['datepicker'],
      bookmark: json['bookmark'],
      siteUrl: json['siteUrl'],
      apiUrl: json['apiUrl'],
      otherUrl: json['otherUrl'],
      photo: json['photo'],
      spot: json['spot'],
      content: json['content'],
      extra: extraList,
      images: imagesList,
      files: json['files'],
    );
  }
}

/// Model representing an individual image in the mayor's selection.
class MayorSelectionImage {
  /// Unique identifier for the image
  final int id;

  /// URL to the image
  final String url;

  /// Creates a new [MayorSelectionImage] instance.
  MayorSelectionImage({
    required this.id,
    required this.url,
  });

  /// Creates a [MayorSelectionImage] from JSON data.
  factory MayorSelectionImage.fromJson(Map<String, dynamic> json) {
    return MayorSelectionImage(
      id: json['id'],
      url: json['url'],
    );
  }
}
