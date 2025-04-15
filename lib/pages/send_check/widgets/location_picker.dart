import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/// Widget for selecting and displaying location
class LocationPicker extends StatefulWidget {
  /// Callback when location is selected
  final Function(Map<String, dynamic>) onLocationSelected;

  /// Currently selected location data
  final Map<String, dynamic>? currentLocation;

  const LocationPicker({
    Key? key,
    required this.onLocationSelected,
    this.currentLocation,
  }) : super(key: key);

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final hasLocation = widget.currentLocation != null;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? Theme.of(context).cardTheme.color : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasLocation) ...[
            // Location information display - daha kompakt
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.currentLocation!['address'] as String,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        '${widget.currentLocation!['latitude'].toStringAsFixed(6)}, ${widget.currentLocation!['longitude'].toStringAsFixed(6)}',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],

          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Text(
                _errorMessage!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 13,
                ),
              ),
            ),

          // Get location button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _getCurrentLocation,
              icon: _isLoading
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    )
                  : Icon(
                      hasLocation ? Icons.refresh_rounded : Icons.my_location,
                      size: 18,
                    ),
              label: Text(
                _isLoading
                    ? 'Konum Alınıyor...'
                    : hasLocation
                        ? 'Konumu Güncelle'
                        : 'Konumumu Al',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: hasLocation
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Theme.of(context).colorScheme.primary,
                foregroundColor: hasLocation
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Gerçek konum alma işlemi
  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Konum izni kontrolü
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Konum izni reddedildi';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoading = false;
          _errorMessage =
              'Konum izinleri kalıcı olarak reddedildi. Ayarlardan izin verebilirsiniz.';
        });
        return;
      }

      // Konum al
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Adres çözümleme
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address = _formatAddress(place);

        final locationData = {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'address': address,
          'accuracy': position.accuracy,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };

        widget.onLocationSelected(locationData);
      } else {
        setState(() {
          _errorMessage = 'Adres bilgisi alınamadı';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Konum alınırken hata oluştu: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Adres bilgilerini formatlama
  String _formatAddress(Placemark place) {
    List<String> addressParts = [
      if (place.thoroughfare?.isNotEmpty == true) place.thoroughfare!,
      if (place.subThoroughfare?.isNotEmpty == true) place.subThoroughfare!,
      if (place.subLocality?.isNotEmpty == true) place.subLocality!,
      if (place.locality?.isNotEmpty == true) place.locality!,
      if (place.administrativeArea?.isNotEmpty == true)
        place.administrativeArea!,
    ];
    return addressParts.join(', ');
  }
}
