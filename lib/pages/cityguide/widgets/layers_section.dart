import 'package:flutter/material.dart';

/// LayersSection displays categorized map layers in an expandable vertical list.
class LayersSection extends StatefulWidget {
  const LayersSection({super.key});

  @override
  State<LayersSection> createState() => _LayersSectionState();
}

class _LayersSectionState extends State<LayersSection> {
  // Mock layer selections
  final Map<String, bool> _layerSelections = {
    'Müzeler': true,
    'Tarihi Yapılar': false,
    'Hastaneler': true,
    'Eczaneler': false,
    'Otobüs Durakları': true,
    'Taksi Durakları': false,
  };

  // Track expanded state for each category
  final Map<String, bool> _expandedState = {
    'Turistik Yerler': false,
    'Hizmetler': false,
    'Ulaşım': false,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Drag handle
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Katmanlar',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        // Expandable list
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _buildLayerCategory(
                context,
                title: 'Turistik Yerler',
                icon: Icons.museum,
                layers: ['Müzeler', 'Tarihi Yapılar'],
              ),
              _buildLayerCategory(
                context,
                title: 'Hizmetler',
                icon: Icons.local_hospital,
                layers: ['Hastaneler', 'Eczaneler'],
              ),
              _buildLayerCategory(
                context,
                title: 'Ulaşım',
                icon: Icons.directions_bus,
                layers: ['Otobüs Durakları', 'Taksi Durakları'],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds an expandable category with layers
  Widget _buildLayerCategory(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<String> layers,
  }) {
    final isExpanded = _expandedState[title] ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surfaceContainer,
            Theme.of(context).colorScheme.surfaceContainerHighest,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _expandedState[title] = !isExpanded;
              });
            },
            child: Column(
              children: [
                // Category header
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.expand_more,
                          size: 20,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                // Layers (shown when expanded)
                if (isExpanded)
                  Container(
                    padding:
                        const EdgeInsets.only(left: 48, right: 12, bottom: 12),
                    child: Column(
                      children: layers
                          .map((layer) => _buildLayerItem(context, layer))
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds an individual layer item with a checkbox
  Widget _buildLayerItem(BuildContext context, String layerName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: _layerSelections[layerName],
              onChanged: (bool? value) {
                setState(() {
                  _layerSelections[layerName] = value ?? false;
                });
              },
              activeColor: Theme.of(context).colorScheme.primary,
              checkColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              layerName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
