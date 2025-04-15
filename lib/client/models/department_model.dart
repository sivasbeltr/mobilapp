class DepartmentModel {
  final int id;
  final String url;
  final String title;
  final String date;
  final String siteUrl;
  final String apiUrl;
  final String? otherUrl;
  final String? photo;
  final String? spot;

  DepartmentModel({
    required this.id,
    required this.url,
    required this.title,
    required this.date,
    required this.siteUrl,
    required this.apiUrl,
    this.otherUrl,
    this.photo,
    this.spot,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      date: json['date'],
      siteUrl: json['siteUrl'],
      apiUrl: json['apiUrl'],
      otherUrl: json['otherUrl'],
      photo: json['photo'],
      spot: json['spot'],
    );
  }
}
