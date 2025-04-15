import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../client/models/mayor_selection_model.dart';
import '../../client/services/mayor_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/pages_app_bar.dart';
import '../show_image_full_page.dart';

/// A page that displays a gallery of photos from the mayor.
class MayorSelectionsPage extends StatefulWidget {
  /// Creates a [MayorSelectionsPage].
  const MayorSelectionsPage({Key? key}) : super(key: key);

  @override
  State<MayorSelectionsPage> createState() => _MayorSelectionsPageState();
}

class _MayorSelectionsPageState extends State<MayorSelectionsPage>
    with SingleTickerProviderStateMixin {
  final MayorService _service = MayorService();
  bool _isLoading = true;
  String? _error;
  MayorSelectionModel? _selections;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadSelections();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Loads the mayor selection data
  Future<void> _loadSelections() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final selections = await _service.getMayorSelections();
      setState(() {
        _selections = selections;
        _isLoading = false;
      });
      _animationController.forward();
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PagesAppBar(
        title: 'Başkandan Seçmeler',
        useRoundedBottom: false,
        useGradientBackground: true,
      ),
      body: _buildBody(context),
    );
  }

  /// Builds the main body of the page based on loading state
  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_error != null) {
      return _buildErrorState();
    }

    // Empty state
    if (_selections == null || _selections!.images.isEmpty) {
      return _buildEmptyState();
    }

    // Content - image grid
    return _buildImageGrid();
  }

  /// Builds an elegant loading state
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Fotoğraflar yükleniyor...',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  /// Builds an elegant error state
  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                Icons.error_outline,
                size: 40,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Fotoğraflar yüklenemedi',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Lütfen internet bağlantınızı kontrol edip tekrar deneyin.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadSelections,
              icon: const Icon(Icons.refresh),
              label: const Text('Tekrar Dene'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds an elegant empty state
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.primaryContainer.withAlpha(50),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              Icons.photo_library_outlined,
              size: 60,
              color: Theme.of(context).colorScheme.primary.withAlpha(150),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Henüz Fotoğraf Bulunmuyor',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Başkanımızın fotoğraf koleksiyonu yakında burada olacak.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a grid of images with improved aesthetics
  Widget _buildImageGrid() {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 900 ? 4 : (width > 600 ? 3 : 2);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          padding: const EdgeInsets.only(top: 4, bottom: 24),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.0,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _selections!.images.length,
          itemBuilder: (context, index) {
            final image = _selections!.images[index];
            // Stagger the appearance of items for a nicer effect
            Future.delayed(Duration(milliseconds: 30 * index));
            return _buildImageItem(context, image, index);
          },
        ),
      ),
    );
  }

  /// Builds an individual image item in the grid with enhanced styling
  Widget _buildImageItem(
      BuildContext context, MayorSelectionImage image, int index) {
    return Hero(
      tag: 'mayor_selection_${image.id}',
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shadowColor: Colors.black26,
        child: InkWell(
          onTap: () => _openFullScreenImage(context, image, index),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image
                CachedNetworkImage(
                  imageUrl: image.url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Icon(
                      Icons.broken_image,
                      size: 40,
                      color:
                          Theme.of(context).colorScheme.primary.withAlpha(100),
                    ),
                  ),
                ),

                // Subtle gradient overlay for better visual depth
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black.withAlpha(40),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Image number indicator
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Opens the selected image in full screen
  void _openFullScreenImage(
      BuildContext context, MayorSelectionImage image, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowImageFullPage(
          imageUrl: image.url,
          title: '${_selections?.title ?? 'Fotoğraf'} ${index + 1}',
        ),
      ),
    );
  }
}
