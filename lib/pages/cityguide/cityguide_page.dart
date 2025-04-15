import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../core/widgets/pages_app_bar.dart';
import 'widgets/layers_section.dart';

class CityGuidePage extends StatefulWidget {
  const CityGuidePage({super.key});

  @override
  State<CityGuidePage> createState() => _CityGuidePageState();
}

class _CityGuidePageState extends State<CityGuidePage> {
  static const LatLng _sivasCityCenter = LatLng(39.7477, 37.0172);
  final MapController _mapController = MapController();
  LatLng? _currentLocation; // Store user's current location

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Fetch location on initialization
  }

  /// Gets the user's current location and updates the state
  Future<void> _getCurrentLocation() async {
    try {
      // Check and request location permission
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return; // Permission denied
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return; // Permission permanently denied
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PagesAppBar(
        title: 'Kent Rehberi',
        showBackButton: true,
        showLogo: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildMap(),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildMapControlButton(
                        icon: Icons.zoom_in,
                        onPressed: () {
                          final currentZoom = _mapController.camera.zoom;
                          _mapController.move(
                            _mapController.camera.center,
                            currentZoom + 1,
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildMapControlButton(
                        icon: Icons.zoom_out,
                        onPressed: () {
                          final currentZoom = _mapController.camera.zoom;
                          _mapController.move(
                            _mapController.camera.center,
                            currentZoom - 1,
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildMapControlButton(
                        icon: Icons.my_location,
                        onPressed: () {
                          if (_currentLocation != null) {
                            _mapController.move(_currentLocation!, 18);
                          } else {
                            _mapController.move(_sivasCityCenter, 13);
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildMapControlButton(
                        icon: Icons.layers,
                        onPressed: () {
                          _showLayersBottomSheet(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: _sivasCityCenter,
        initialZoom: 13.0,
        minZoom: 5.0,
        maxZoom: 18.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'tr.bel.sivas.mobilapp',
          maxNativeZoom: 19,
          maxZoom: 19,
          tileProvider: NetworkTileProvider(),
        ),
        MarkerLayer(
          markers: [
            // Current location marker (only shown if location is available)
            if (_currentLocation != null)
              Marker(
                point: _currentLocation!,
                width: 40,
                height: 40,
                alignment: Alignment.bottomCenter,
                child: Icon(
                  Icons.location_on,
                  size: 40,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            // Other markers
            Marker(
              point: const LatLng(39.75557694017734, 37.01152228289493),
              width: 30,
              height: 30,
              alignment: Alignment.bottomCenter,
              child: Icon(
                Icons.account_balance,
                size: 30,
                color: Theme.of(context).colorScheme.secondary,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            Marker(
              point: const LatLng(39.749959175607394, 37.0136344305697),
              width: 30,
              height: 30,
              alignment: Alignment.bottomCenter,
              child: Icon(
                Icons.museum,
                size: 30,
                color: Theme.of(context).colorScheme.tertiary,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap ve katkıcıları',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMapControlButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(12),
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
        shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.3),
      ),
      child: Icon(icon, size: 24),
    );
  }

  void _showLayersBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.35,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return const LayersSection();
          },
        );
      },
    );
  }
}
