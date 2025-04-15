import 'package:flutter/material.dart';
import 'package:sivas_belediyesi/core/widgets/pages_app_bar.dart';

/// Detailed fire emergency instructions
class FirePage extends StatelessWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const FirePage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PagesAppBar(
        title: 'YANGIN',
        showBackButton: true,
        showLogo: true,
        hasElevation: true,
        elevationValue: 3,
        useRoundedBottom: false,
        useGradientBackground: false,
        backIcon: Icons.arrow_back_ios_rounded,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey.withOpacity(0.3),
                child: const Icon(
                  Icons.local_fire_department,
                  size: 80,
                  color: Color(0xFFFF6F00),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Introduction
            Text(
              'Yangın Durumunda Yapılması Gerekenler',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF6F00),
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Yangın durumunda sakin kalın ve doğru davranışlarda bulunun. Aşağıdaki talimatları mutlaka takip edin.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            // During fire section
            _buildSection(
              context,
              title: 'Yangın Sırasında',
              icon: Icons.access_time,
              instructions: [
                _buildInstruction(
                  context,
                  'Sakin kalın, hemen itfaiyeyi (110) arayın ve kesin adres verin.',
                  Icons.call,
                ),
                _buildInstruction(
                  context,
                  'Eğer yangın küçükse ve güvenliyse yangın söndürücü kullanarak söndürmeyi deneyin.',
                  Icons.fire_extinguisher,
                ),
                _buildInstruction(
                  context,
                  'Dumanlı ortamda eğilerek, mümkünse ıslak bir bezle ağzınızı ve burnunuzu kapatarak ilerleyin.',
                  Icons.height,
                ),
                _buildInstruction(
                  context,
                  'Kapalı kapıları açmadan önce sıcaklığını kontrol edin, sıcaksa başka bir çıkış arayın.',
                  Icons.door_sliding,
                ),
                _buildInstruction(
                  context,
                  'Asla asansör kullanmayın, her zaman merdivenleri tercih edin.',
                  Icons.elevator,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // After fire section
            _buildSection(
              context,
              title: 'Yangın Sonrası',
              icon: Icons.update,
              instructions: [
                _buildInstruction(
                  context,
                  'Uzmanlar güvenli olduğunu söyleyene kadar yangın yerine geri dönmeyin.',
                  Icons.security,
                ),
                _buildInstruction(
                  context,
                  'Yaralı varsa ilk yardım uygulayın ve sağlık ekiplerini bekleyin.',
                  Icons.medical_services,
                ),
                _buildInstruction(
                  context,
                  'Sigorta işlemleri için hasarın fotoğraflarını çekin ve kayıt altına alın.',
                  Icons.photo_camera,
                ),
                _buildInstruction(
                  context,
                  'Elektrik, su ve gaz gibi tesisatları kontrol etmeden kullanmayın.',
                  Icons.power,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Prevention section
            _buildSection(
              context,
              title: 'Yangın Önleme',
              icon: Icons.checklist,
              instructions: [
                _buildInstruction(
                  context,
                  'Evinizde duman dedektörleri ve yangın söndürücüler bulundurun.',
                  Icons.sensors,
                ),
                _buildInstruction(
                  context,
                  'Elektrik tesisatını düzenli olarak kontrol ettirin.',
                  Icons.electrical_services,
                ),
                _buildInstruction(
                  context,
                  'Isıtıcıları yanıcı maddelerden uzak tutun.',
                  Icons.whatshot,
                ),
                _buildInstruction(
                  context,
                  'Yanıcı maddeleri güvenli şekilde depolayın.',
                  Icons.inventory,
                ),
                _buildInstruction(
                  context,
                  'Aile üyeleriyle yangın tahliye planı oluşturun ve tatbikat yapın.',
                  Icons.family_restroom,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Important contacts reminder
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.contact_phone, color: Color(0xFFFF6F00)),
                      const SizedBox(width: 8),
                      Text(
                        'Acil Durumda Aranacak Numaralar',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildContactRow(context, 'İtfaiye', '110'),
                  _buildContactRow(context, 'Acil Çağrı Merkezi', '112'),
                  _buildContactRow(context, 'Sivas Belediyesi', '444 58 44'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widgets
  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> instructions,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFFFF6F00), size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        ...instructions,
      ],
    );
  }

  Widget _buildInstruction(BuildContext context, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6F00).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: const Color(0xFFFF6F00)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(BuildContext context, String name, String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            number,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFF6F00),
                ),
          ),
        ],
      ),
    );
  }
}
