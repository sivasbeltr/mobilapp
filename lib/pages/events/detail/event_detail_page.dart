import 'package:flutter/material.dart';
import '../../../client/services/http_client_service.dart';
import '../../../core/theme/app_colors.dart';

/// Displays the details of an event.
class EventDetailPage extends StatefulWidget {
  /// The ID of the event to display.
  final String id;

  /// Creates a new [EventDetailPage].
  const EventDetailPage({super.key, required this.id});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  final HttpClientService _httpClient = HttpClientService();
  bool _isLoading = true;
  String _title = '';
  String _description = '';
  String _date = '';
  String _location = '';
  final String _imageUrl =
      'assets/images/sivas_placeholder.jpg'; // Default image

  @override
  void initState() {
    super.initState();
    _loadEventDetails();
  }

  /// Loads the event details from the API.
  Future<void> _loadEventDetails() async {
    setState(() => _isLoading = true);

    try {
      // In a real implementation, we would fetch from API
      // For demonstration, using dummy content with a delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock data
      setState(() {
        _title = 'Sivas Kültür ve Sanat Festivali';
        _date = '01.08.2023 - 05.08.2023';
        _location = 'Sivas Kent Meydanı';
        _description = '''
Sivas Belediyesi'nin düzenlediği Kültür ve Sanat Festivali bu yıl 5. kez düzenlenecek. 

Festival kapsamında:
- Konserler
- Tiyatro gösterileri
- Sergi açılışları
- Çocuklar için etkinlikler
- Geleneksel el sanatları çalıştayları
- Yöresel yemek tanıtımları

yer alacak. Festival beş gün boyunca sürecek ve tüm etkinlikler halka ücretsiz olarak sunulacak.

Açılış töreni 1 Ağustos saat 19:00'da Kent Meydanı'nda gerçekleşecek ve açılış konserini ünlü sanatçı Sivaslı Aşık Veysel'in türkülerinden oluşan özel bir programla başlayacaktır.

Tüm halkımız davetlidir.
''';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _description = 'Etkinlik içeriği yüklenirken bir hata oluştu.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etkinlik Detayı'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: _isLoading ? _buildLoading() : _buildContent(),
    );
  }

  /// Builds the loading indicator.
  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  /// Builds the content of the event detail page.
  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header image
          Image.asset(
            _imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  _title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Date
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _date,
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Location
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _location,
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),

                // Description
                Text(
                  _description,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),

          // Add to calendar button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement add to calendar functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Etkinlik takviminize eklendi!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.calendar_month),
              label: const Text('Takvime Ekle'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
