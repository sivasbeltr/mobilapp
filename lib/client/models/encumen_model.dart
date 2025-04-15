/// Model representing a municipal committee member (encümen).
class EncumenModel {
  /// Unique identifier for the committee member
  final int id;

  /// URL slug for the committee member
  final String url;

  /// Full name of the committee member
  final String title;

  /// Official position/rank of the committee member (e.g., "BELEDİYE BAŞKANI")
  final String rank;

  /// Date information (usually in relative format like "2 ay önce")
  final String date;

  /// Optional date picker value
  final String? datepicker;

  /// Optional website URL
  final String? siteUrl;

  /// Optional API URL for detailed information
  final String? apiUrl;

  /// Optional alternative URL
  final String? otherUrl;

  /// URL to the committee member's photo
  final String? photo;

  /// Optional short description or spot text
  final String? spot;

  /// Optional detailed content about the committee member
  final String? content;

  /// Creates a new [EncumenModel] instance.
  EncumenModel({
    required this.id,
    required this.url,
    required this.title,
    required this.rank,
    required this.date,
    this.datepicker,
    this.siteUrl,
    this.apiUrl,
    this.otherUrl,
    this.photo,
    this.spot,
    this.content,
  });

  /// Creates an [EncumenModel] from JSON data.
  factory EncumenModel.fromJson(Map<String, dynamic> json) {
    return EncumenModel(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      rank: json['rank'],
      date: json['date'],
      datepicker: json['datepicker'],
      siteUrl: json['siteUrl'],
      apiUrl: json['apiUrl'],
      otherUrl: json['otherUrl'],
      photo: json['photo'],
      spot: json['spot'],
      content: json['content'],
    );
  }

  /// Converts this model to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'rank': rank,
      'date': date,
      'datepicker': datepicker,
      'siteUrl': siteUrl,
      'apiUrl': apiUrl,
      'otherUrl': otherUrl,
      'photo': photo,
      'spot': spot,
      'content': content,
    };
  }
}
