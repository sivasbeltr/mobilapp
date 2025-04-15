import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Displays the details of a news article.
class NewsDetailPage extends StatefulWidget {
  /// The ID of the news item to display.
  final String id;

  /// Creates a new [NewsDetailPage].
  const NewsDetailPage({super.key, required this.id});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool _isLoading = true;
  String _title = '';
  String _content = '';
  String _date = '';
  String _imageUrl = 'assets/images/sivas_placeholder.jpg'; // Default image

  @override
  void initState() {
    super.initState();
    _loadNewsDetails();
  }

  /// Loads the news details from the API.
  Future<void> _loadNewsDetails() async {
    setState(() => _isLoading = true);

    try {
      // In a real implementation, we would fetch from API
      // For demonstration, using dummy content with a delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock data
      setState(() {
        _title = 'Belediyemiz Yeni Hizmet Binası Açıldı';
        _date = '15.07.2023';
        _content = '''
Belediyemizin yeni hizmet binası düzenlenen törenle hizmete açıldı. 
        
Sivas Belediye Başkanı Dr. Adem UZUN, açılış konuşmasında vatandaşlara daha iyi hizmet verebilmek için modern tesislere ihtiyaç duyulduğunu belirtti.

Yeni hizmet binası, engelli vatandaşlarımızın erişimi düşünülerek tasarlandı ve enerji tasarruflu sistemlerle donatıldı. Bina içerisinde vatandaşlarımızın tüm belediye hizmetlerine tek noktadan ulaşabilecekleri bir danışma merkezi de bulunuyor.

Açılış törenine Sivas Valisi, milletvekilleri ve çok sayıda vatandaş katıldı.
''';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _content = 'Haber içeriği yüklenirken bir hata oluştu.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Haber Detayı'),
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

  /// Builds the content of the news detail page.
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

                const SizedBox(height: 8),

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

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),

                // Content
                Text(
                  _content,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
