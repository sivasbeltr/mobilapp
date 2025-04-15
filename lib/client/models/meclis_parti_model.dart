/// Model representing a political party in the municipal council.
class MeclisPartiModel {
  /// Unique identifier for the party
  final int id;

  /// URL slug for the party
  final String url;

  /// Full name of the political party
  final String title;

  /// Date information (usually in relative format like "5 ay önce")
  final String date;

  /// Optional date picker value
  final String? datepicker;

  /// Website URL for party members list
  final String? siteUrl;

  /// API URL for fetching party members
  final String? apiUrl;

  /// Optional alternative URL
  final String? otherUrl;

  /// Optional URL to the party's logo or image
  final String? photo;

  /// Optional short description or spot text
  final String? spot;

  /// Creates a new [MeclisPartiModel] instance.
  MeclisPartiModel({
    required this.id,
    required this.url,
    required this.title,
    required this.date,
    this.datepicker,
    this.siteUrl,
    this.apiUrl,
    this.otherUrl,
    this.photo,
    this.spot,
  });

  /// Creates a [MeclisPartiModel] from JSON data.
  factory MeclisPartiModel.fromJson(Map<String, dynamic> json) {
    return MeclisPartiModel(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      date: json['date'],
      datepicker: json['datepicker'],
      siteUrl: json['siteUrl'],
      apiUrl: json['apiUrl'],
      otherUrl: json['otherUrl'],
      photo: json['photo'],
      spot: json['spot'],
    );
  }

  /// Converts this model to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'date': date,
      'datepicker': datepicker,
      'siteUrl': siteUrl,
      'apiUrl': apiUrl,
      'otherUrl': otherUrl,
      'photo': photo,
      'spot': spot,
    };
  }
}
