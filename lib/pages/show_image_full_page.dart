import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// A full-screen image viewer page with zoom and save capabilities.
///
/// This page displays an image from a provided URL in full screen with
/// zoom functionality, and allows the user to save the image to their device.
class ShowImageFullPage extends StatefulWidget {
  /// The URL of the image to display.
  final String imageUrl;

  /// Optional title to display in the app bar.
  final String? title;

  /// Creates a [ShowImageFullPage].
  const ShowImageFullPage({
    Key? key,
    required this.imageUrl,
    this.title,
  }) : super(key: key);

  @override
  State<ShowImageFullPage> createState() => _ShowImageFullPageState();
}

class _ShowImageFullPageState extends State<ShowImageFullPage> {
  bool _isLoading = false;
  bool _isSaving = false;
  final PhotoViewScaleStateController _scaleStateController =
      PhotoViewScaleStateController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withAlpha(150),
        foregroundColor: Colors.white,
        elevation: 0,
        title: widget.title != null
            ? Text(widget.title!, style: const TextStyle(color: Colors.white))
            : null,
        actions: [
          // Share button
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareImage,
            tooltip: 'Paylaş',
          ),
          // Zoom reset button
          IconButton(
            icon: const Icon(Icons.zoom_out_map),
            onPressed: _resetZoom,
            tooltip: 'Yakınlaştırmayı Sıfırla',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Photo view for zooming
          PhotoView(
            imageProvider: CachedNetworkImageProvider(widget.imageUrl),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            scaleStateController: _scaleStateController,
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  value: event == null || event.expectedTotalBytes == null
                      ? 0
                      : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            errorBuilder: (context, error, stackTrace) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.broken_image,
                    color: theme.colorScheme.error,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Resim yüklenemedi',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Loading indicator overlay
          if (_isLoading)
            Container(
              color: Colors.black.withAlpha(100),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Resets the zoom level back to the initial scale
  void _resetZoom() {
    _scaleStateController.scaleState = PhotoViewScaleState.initial;
  }

  /// Shares the image with other apps
  Future<void> _shareImage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Download the image
      final response = await http.get(Uri.parse(widget.imageUrl));

      // Get temporary directory to store the image
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/shared_image.jpg');
      await file.writeAsBytes(response.bodyBytes);

      // Share the image
      await Share.shareXFiles(
        [XFile(file.path)],
        text: widget.title ?? 'Sivas Belediyesi',
      );
    } catch (e) {
      // Show error message
      if (!mounted) return;

      final theme = Theme.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Resim paylaşılamadı'),
          backgroundColor: theme.colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
