import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/widgets/pages_app_bar.dart';
import 'services/send_check_service.dart';
import 'widgets/category_selector.dart';
import 'widgets/image_picker_card.dart';
import 'widgets/location_picker.dart';

/// Page for sending photos and reports to municipality
class SendCheckPage extends StatefulWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const SendCheckPage({super.key, this.parameters});

  @override
  State<SendCheckPage> createState() => _SendCheckPageState();
}

class _SendCheckPageState extends State<SendCheckPage> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();

  List<String> images = [];
  String? selectedCategory;
  Map<String, dynamic>? location;
  bool _isSubmitting = false;
  String? _errorMessage;
  bool _canSubmit = true;
  int _remainingTimeInSeconds = 0;

  // Categories for issue reporting
  final List<Map<String, dynamic>> _categories = [
    {'id': 'road', 'name': 'Yol Sorunu', 'icon': Icons.add_road},
    {'id': 'water', 'name': 'Su Sorunu', 'icon': Icons.water_drop},
    {'id': 'garbage', 'name': 'Çöp/Atık', 'icon': Icons.delete},
    {'id': 'park', 'name': 'Park/Bahçe', 'icon': Icons.park},
    {'id': 'traffic', 'name': 'Trafik', 'icon': Icons.traffic},
    {'id': 'street_light', 'name': 'Sokak Aydınlatma', 'icon': Icons.lightbulb},
    {'id': 'stray_animal', 'name': 'Sokak Hayvanları', 'icon': Icons.pets},
    {'id': 'environment', 'name': 'Çevre Kirliliği', 'icon': Icons.nature},
    {'id': 'sidewalk', 'name': 'Kaldırım', 'icon': Icons.directions_walk},
    {'id': 'noise', 'name': 'Gürültü', 'icon': Icons.volume_up},
    {'id': 'other', 'name': 'Diğer', 'icon': Icons.more_horiz},
  ];

  @override
  void initState() {
    super.initState();
    _checkLastSubmissionTime();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  /// Checks if user can submit based on last submission time
  void _checkLastSubmissionTime() async {
    final lastSubmissionTime = await SendCheckService.getLastSubmissionTime();
    if (lastSubmissionTime != null) {
      final now = DateTime.now();
      final difference = now.difference(lastSubmissionTime);
      final remainingTime = const Duration(minutes: 10) - difference;

      if (remainingTime.isNegative) {
        setState(() {
          _canSubmit = true;
        });
      } else {
        setState(() {
          _canSubmit = false;
          _remainingTimeInSeconds = remainingTime.inSeconds;
        });
        _startCountdown();
      }
    } else {
      setState(() {
        _canSubmit = true;
      });
    }
  }

  /// Starts countdown timer for next submission
  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_remainingTimeInSeconds > 0) {
            _remainingTimeInSeconds--;
            _startCountdown();
          } else {
            _canSubmit = true;
          }
        });
      }
    });
  }

  /// Formats remaining time as mm:ss
  String _formatRemainingTime() {
    final minutes = (_remainingTimeInSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTimeInSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Handle form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() == true) {
      if (images.isEmpty) {
        setState(() => _errorMessage = 'Lütfen en az bir fotoğraf ekleyiniz');
        return;
      }
      if (selectedCategory == null) {
        setState(() => _errorMessage = 'Lütfen bir kategori seçiniz');
        return;
      }
      if (location == null) {
        setState(() => _errorMessage = 'Konum bilgisi gereklidir');
        return;
      }

      setState(() {
        _errorMessage = null;
        _isSubmitting = true;
      });

      try {
        await SendCheckService.submitReport(
          images: images,
          category: selectedCategory!,
          location: location!,
          message: _messageController.text,
        );

        if (mounted) {
          setState(() {
            _isSubmitting = false;
            _canSubmit = false;
            _remainingTimeInSeconds = 600; // 10 minutes
            images = [];
            selectedCategory = null;
            location = null;
            _messageController.clear();
          });

          _startCountdown();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Bildiriminiz başarıyla gönderildi. Teşekkür ederiz!',
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
            _errorMessage = 'Gönderim sırasında bir hata oluştu: $e';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const PagesAppBar(
        title: 'Çek Gönder',
        showBackButton: true,
        showLogo: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header - daha kompakt
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
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
                          Icons.photo_camera,
                          size: 24,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sorun Bildir',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Fotoğraflayarak hızlıca belediyeye iletebilirsiniz',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Sections with compact spacing
              _buildSectionTitle('Fotoğraflar (En fazla 3 adet)'),
              const SizedBox(height: 8),
              ImagePickerCard(
                images: images,
                onImagesChanged: (updatedImages) {
                  setState(() => images = updatedImages);
                },
                maxImages: 3,
                onPickImage: _pickImage,
              ),

              const SizedBox(height: 16),

              _buildSectionTitle('Sorun Kategorisi'),
              const SizedBox(height: 8),
              CategorySelector(
                categories: _categories,
                selectedCategory: selectedCategory,
                onCategorySelected: (categoryId) {
                  setState(() => selectedCategory = categoryId);
                },
              ),

              const SizedBox(height: 16),

              _buildSectionTitle('Konum'),
              const SizedBox(height: 4),
              Text(
                'Son konumunuz otomatik olarak alınacaktır',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              LocationPicker(
                onLocationSelected: (locationData) {
                  setState(() => location = locationData);
                },
                currentLocation: location,
              ),

              const SizedBox(height: 16),

              _buildSectionTitle('Açıklama'),
              const SizedBox(height: 4),
              Text(
                'Sorunu kısaca açıklayın (en az 10 karakter)',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Theme.of(context).cardTheme.color
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Sorun hakkında bilgi verin...',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    counterText: '${_messageController.text.length} / 500',
                  ),
                  maxLines: 4, // 5'ten 4'e düşürüldü
                  maxLength: 500,
                  validator: (value) {
                    if (value == null || value.length < 10) {
                      return 'Lütfen en az 10 karakter giriniz';
                    }
                    return null;
                  },
                ),
              ),

              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Theme.of(context).colorScheme.error,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Submit button section - daha kompakt
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed:
                            _canSubmit && !_isSubmitting ? _submitForm : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          disabledBackgroundColor: Colors.grey.shade300,
                        ),
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                _canSubmit
                                    ? 'Gönder'
                                    : '${_formatRemainingTime()} sonra gönder',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              // Info text - kompakt
              if (!_canSubmit)
                Center(
                  child: Text(
                    '* Her 10 dakikada bir bildirim gönderebilirsiniz.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                          fontSize: 11,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Bölüm başlığı widget'i - tekrarlamayı önlemek için
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  /// Gerçek fotoğraf seçme fonksiyonu
  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 85, // Görüntü kalitesi
      );

      if (pickedFile != null) {
        setState(() {
          images.add(pickedFile.path);
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Fotoğraf seçilirken bir hata oluştu: $e';
      });
    }
  }
}
