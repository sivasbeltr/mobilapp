import 'package:shared_preferences/shared_preferences.dart';

/// Service class for handling send check functionality
class SendCheckService {
  static const String _lastSubmissionTimeKey =
      'last_send_check_submission_time';

  /// Gets the timestamp of the last report submission
  static Future<DateTime?> getLastSubmissionTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_lastSubmissionTimeKey);

    if (timestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }

    return null;
  }

  /// Submits a new report to the server
  static Future<void> submitReport({
    required List<String> images,
    required String category,
    required Map<String, dynamic> location,
    required String message,
  }) async {
    // Create multipart form data

    // Image upload handling
    var imageFiles = <Map<String, dynamic>>[];
    for (var i = 0; i < images.length; i++) {
      imageFiles.add({
        'path': images[i],
        'name': 'image_$i.jpg',
        'field': 'images[$i]',
      });
    }

    // Make API call to submit the report
    try {
      // await _httpClient.postMultipart(
      //   endpoint: '/citizen-reports/submit',
      //   data: formData,
      //   files: imageFiles,
      // );

      // Fake implementation: Simulate network delay and success
      await Future.delayed(const Duration(seconds: 2));
      // You can optionally simulate an error here for testing purposes
      // throw Exception('Fake submission error');

      // Store submission time
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(
        _lastSubmissionTimeKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      rethrow; // Let the UI handle the error
    }
  }

  /// Checks if user can submit a new report based on the 10-minute rule
  static Future<bool> canSubmitReport() async {
    final lastSubmissionTime = await getLastSubmissionTime();

    if (lastSubmissionTime == null) {
      return true;
    }

    final now = DateTime.now();
    final difference = now.difference(lastSubmissionTime);

    // Allow one submission every 10 minutes
    return difference.inMinutes >= 10;
  }

  /// Gets the remaining time until next submission is allowed
  static Future<Duration> getRemainingTimeUntilNextSubmission() async {
    final lastSubmissionTime = await getLastSubmissionTime();

    if (lastSubmissionTime == null) {
      return Duration.zero;
    }

    final now = DateTime.now();
    final nextSubmissionTime =
        lastSubmissionTime.add(const Duration(minutes: 10));

    if (now.isAfter(nextSubmissionTime)) {
      return Duration.zero;
    }

    return nextSubmissionTime.difference(now);
  }
}
