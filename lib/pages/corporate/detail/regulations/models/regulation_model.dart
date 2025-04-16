/// Model representing a regulation document.
class RegulationModel {
  /// The title of the regulation
  final String title;

  /// The URL to the PDF document
  final String pdfUrl;

  /// The category of the regulation (e.g., Ulaşım, Çevre, etc.)
  final String category;

  /// The icon to represent the regulation category
  final dynamic icon;

  /// Creates a new [RegulationModel].
  RegulationModel({
    required this.title,
    required this.pdfUrl,
    required this.category,
    required this.icon,
  });
}
