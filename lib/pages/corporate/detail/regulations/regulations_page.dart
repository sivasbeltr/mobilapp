import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/pages_app_bar.dart';
import 'widgets/regulation_item.dart';
import 'models/regulation_model.dart';

/// A page that displays the municipality regulations with downloadable PDF links.
class RegulationsPage extends StatefulWidget {
  /// Creates a [RegulationsPage].
  const RegulationsPage({Key? key}) : super(key: key);

  @override
  State<RegulationsPage> createState() => _RegulationsPageState();
}

class _RegulationsPageState extends State<RegulationsPage> {
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  final List<RegulationModel> _regulations = [];
  List<RegulationModel> _filteredRegulations = [];

  @override
  void initState() {
    super.initState();
    _loadRegulations();

    // Add listener to the search controller
    _searchController.addListener(() {
      _filterRegulations(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Loads the list of regulations.
  void _loadRegulations() {
    // In a real app, this would come from an API
    _regulations.addAll([
      RegulationModel(
        title:
            'Alışveriş Merkezleri, Büyük Mağazalar, Zincir Mağazalar ve Marketlerin Kuruluşuna Dair Yönetmelik',
        pdfUrl:
            'https://www.sivas.bel.tr/upload/files/disiplin-amirligi-yonetmelikleri/disiplin-amirligi-yonetmelikleri_7437.pdf',
        category: 'Ticaret',
        icon: Icons.store,
      ),
      RegulationModel(
        title: 'Atıksuların Kanalizasyon Şebekesine Deşarj Yönetmeliği',
        pdfUrl:
            'https://www.sivas.bel.tr/upload/files/disiplin-amirligi-yonetmelikleri/disiplin-amirligi-yonetmelikleri_2173.pdf',
        category: 'Çevre',
        icon: Icons.water_drop,
      ),
      RegulationModel(
        title: 'Baca Temizleme ve Denetim Yönetmeliği',
        pdfUrl:
            'https://www.sivas.bel.tr/upload/files/disiplin-amirligi-yonetmelikleri/disiplin-amirligi-yonetmelikleri_8778.pdf',
        category: 'Güvenlik',
        icon: Icons.fireplace,
      ),
      RegulationModel(
        title: 'Disiplin Amirleri Yönetmeliği',
        pdfUrl:
            'https://www.sivas.bel.tr/upload/files/disiplin-amirligi-yonetmelikleri/disiplin-amirligi-yonetmelikleri_8161.pdf',
        category: 'İdari',
        icon: Icons.gavel,
      ),
      RegulationModel(
        title: 'Hizmet İçi Eğitim Yönetmeliği',
        pdfUrl:
            'https://www.sivas.bel.tr/upload/files/disiplin-amirligi-yonetmelikleri/disiplin-amirligi-yonetmelikleri_3353.pdf',
        category: 'Eğitim',
        icon: Icons.school,
      ),
      RegulationModel(
        title: 'Özel Halk Otobüsleri Çalışma ve Seyrüsefer Yönetmeliği',
        pdfUrl:
            'https://www.sivas.bel.tr/upload/files/disiplin-amirligi-yonetmelikleri/disiplin-amirligi-yonetmelikleri_166.pdf',
        category: 'Ulaşım',
        icon: Icons.directions_bus,
      ),
      RegulationModel(
        title:
            'Özel Halk Otobüsleri Çalışma ve Seyrüsefer Yönetmeliğinde Düzenleme Yapılması',
        pdfUrl:
            'https://www.sivas.bel.tr/upload/files/disiplin-amirligi-yonetmelikleri/disiplin-amirligi-yonetmelikleri_9788.pdf',
        category: 'Ulaşım',
        icon: Icons.directions_bus,
      ),
      RegulationModel(
        title: 'Özel Servis Araçları Yönetmeliği',
        pdfUrl:
            'https://www.sivas.bel.tr/upload/files/disiplin-amirligi-yonetmelikleri/disiplin-amirligi-yonetmelikleri_1411.pdf',
        category: 'Ulaşım',
        icon: Icons.airport_shuttle,
      ),
      RegulationModel(
        title:
            'Pide, Lavaş, Simit ve Unlu Mamuller Üreten İşyerlerine Dair Yönetmelik',
        pdfUrl:
            'https://www.sivas.bel.tr/upload/files/disiplin-amirligi-yonetmelikleri/disiplin-amirligi-yonetmelikleri_5761.pdf',
        category: 'Gıda',
        icon: Icons.bakery_dining,
      ),
      RegulationModel(
        title: 'Ticari Taksi Yönetmeliği',
        pdfUrl:
            'https://www.sivas.bel.tr/upload/files/disiplin-amirligi-yonetmelikleri/disiplin-amirligi-yonetmelikleri_1614.pdf',
        category: 'Ulaşım',
        icon: Icons.local_taxi,
      ),
      RegulationModel(
        title: 'Toplu Taşıma Araçları Seyahat Kartları Uygulama Yönetmeliği',
        pdfUrl:
            'https://www.sivas.bel.tr/upload/files/disiplin-amirligi-yonetmelikleri/disiplin-amirligi-yonetmelikleri_2693.pdf',
        category: 'Ulaşım',
        icon: Icons.credit_card,
      ),
    ]);

    // Initialize filtered list with all regulations
    _filteredRegulations = List.from(_regulations);
  }

  /// Filters the regulations based on search text.
  void _filterRegulations(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        _filteredRegulations = List.from(_regulations);
      } else {
        _filteredRegulations = _regulations
            .where((regulation) => regulation.title
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  /// Opens the PDF in an external browser or PDF viewer.
  Future<void> _openPdf(String url) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar('PDF dosyası açılamadı');
      }
    } catch (e) {
      _showErrorSnackBar('Hata: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Shows an error message to the user.
  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const PagesAppBar(
        title: 'Yönetmelikler',
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Header with search
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      isDark
                          ? AppColors.primary.withAlpha(180)
                          : AppColors.primaryLight,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  children: [
                    // Search bar
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Yönetmelik ara...',
                        hintStyle: const TextStyle(color: Colors.white70),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.white),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear,
                                    color: Colors.white),
                                onPressed: () {
                                  _searchController.clear();
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white.withAlpha(50),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                    ),
                  ],
                ),
              ),

              // Information text
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: theme.colorScheme.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Yönetmelik PDF dosyalarını görüntülemek için tıklayın.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),

              // List of regulations
              Expanded(
                child: _filteredRegulations.isEmpty
                    ? _buildEmptyState(theme)
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredRegulations.length,
                        itemBuilder: (context, index) {
                          final regulation = _filteredRegulations[index];
                          return RegulationItem(
                            regulation: regulation,
                            onTap: () => _openPdf(regulation.pdfUrl),
                          );
                        },
                      ),
              ),
            ],
          ),

          // Loading indicator
          if (_isLoading)
            Container(
              color: Colors.black.withAlpha(70),
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

  /// Builds an empty state widget when no regulations match the search.
  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: theme.colorScheme.primary.withAlpha(100),
          ),
          const SizedBox(height: 16),
          Text(
            _searchController.text.isNotEmpty
                ? 'Aramanıza uygun yönetmelik bulunamadı'
                : 'Yönetmelik bulunamadı',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              _searchController.clear();
            },
            child: const Text('Filtreyi Temizle'),
          ),
        ],
      ),
    );
  }
}
