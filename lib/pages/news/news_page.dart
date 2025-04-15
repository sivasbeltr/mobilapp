import 'package:flutter/material.dart';
import 'package:sivas_belediyesi/core/widgets/pages_app_bar.dart';
import '../../core/theme/app_colors.dart';

/// Displays a full list of news articles from the municipality.
class NewsPage extends StatefulWidget {
  /// Creates a new [NewsPage].
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    // Simulate API call with delay
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PagesAppBar(
        title: 'Haberler',
        useGradientBackground: false,
        roundedBottomRadius: 0,
        useRoundedBottom: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 80,
                      color: AppColors.primary.withAlpha(150),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Bu sayfa henüz yapım aşamasındadır.',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Daha sonra tekrar ziyaret ediniz.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
