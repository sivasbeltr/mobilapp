import 'package:flutter/material.dart';
import '../../widgets/home/feature_card.dart';

/// Grid of feature cards for the home page
class FeaturesGrid extends StatelessWidget {
  /// List of features to display in the grid
  final List<Map<String, dynamic>> features;

  const FeaturesGrid({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return FeatureCard(
          title: feature['title'],
          icon: feature['icon'],
          onTap: () {
            // Navigate to feature page
            Navigator.pushNamed(context, feature['route']);
          },
        );
      },
    );
  }
}
