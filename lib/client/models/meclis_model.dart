/// Model representing a council member (meclis üyesi) from the municipality council.
class MeclisModel {
  /// Unique identifier for the council member
  final int id;

  /// URL slug for the council member
  final String url;

  /// Full name of the council member
  final String title;

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

  /// URL to the council member's photo
  final String? photo;

  /// Optional short description or spot text
  final String? spot;

  /// Optional detailed content about the council member
  final String? content;

  /// Political party affiliation of the council member
  final String? party;

  /// Creates a new [MeclisModel] instance.
  MeclisModel({
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
    this.content,
    this.party,
  });

  /// Creates a [MeclisModel] from JSON data.
  factory MeclisModel.fromJson(Map<String, dynamic> json) {
    return MeclisModel(
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
      content: json['content'],
      party: json['party'],
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
      'content': content,
      'party': party,
    };
  }
}
