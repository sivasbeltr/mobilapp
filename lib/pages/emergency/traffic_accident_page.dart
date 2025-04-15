import 'package:flutter/material.dart';
import 'package:sivas_belediyesi/core/widgets/pages_app_bar.dart';

/// Detailed traffic accident emergency instructions
class TrafficAccidentPage extends StatelessWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const TrafficAccidentPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PagesAppBar(
        title: 'TRAFİK KAZASI',
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
                color: Colors.grey.withAlpha(76),
                child: const Icon(
                  Icons.car_crash,
                  size: 80,
                  color: Color(0xFF283593),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Introduction
            Text(
              'Trafik Kazası Durumunda Yapılması Gerekenler',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF283593),
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Trafik kazalarında doğru ve hızlı müdahale hayat kurtarır. Sakin kalın ve aşağıdaki adımları izleyin.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            // Immediate actions section
            _buildSection(
              context,
              title: 'Kaza Anında',
              icon: Icons.access_time,
              instructions: [
                _buildInstruction(
                  context,
                  'Aracınızı güvenli bir yere çekin ve dörtlü flaşörlerinizi açın.',
                  Icons.car_rental,
                ),
                _buildInstruction(
                  context,
                  'Reflektör veya üçgen kullanarak diğer sürücüleri uyarın.',
                  Icons.warning,
                ),
                _buildInstruction(
                  context,
                  'Acil Çağrı Merkezi\'ni (112) arayın, kesin konum ve yaralı durumu bildirin.',
                  Icons.call,
                ),
                _buildInstruction(
                  context,
                  'Yaralıları hareket ettirmeyin, sadece hayati tehlike varsa müdahale edin.',
                  Icons.medical_services,
                ),
                _buildInstruction(
                  context,
                  'Araçta yangın tehlikesi varsa, herkesi uzaklaştırın.',
                  Icons.local_fire_department,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // First aid section
            _buildSection(
              context,
              title: 'İlk Yardım',
              icon: Icons.health_and_safety,
              instructions: [
                _buildInstruction(
                  context,
                  'Yaralının bilinci açıksa, sakin bir şekilde konuşun ve hareket etmesini engelleyin.',
                  Icons.person,
                ),
                _buildInstruction(
                  context,
                  'Yaralının bilinci kapalıysa, hava yolunu açık tutmaya çalışın.',
                  Icons.airline_seat_flat,
                ),
                _buildInstruction(
                  context,
                  'Ciddi kanama varsa, temiz bir bezle baskı uygulayın.',
                  Icons.healing,
                ),
                _buildInstruction(
                  context,
                  'Yaralıyı sıcak tutmaya çalışın, battaniye veya mont ile örtün.',
                  Icons.thermostat,
                ),
                _buildInstruction(
                  context,
                  'Yaralıya su dahil hiçbir şey içirmeyin veya yedirmeyin.',
                  Icons.no_drinks,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // After accident section
            _buildSection(
              context,
              title: 'Kaza Sonrası',
              icon: Icons.update,
              instructions: [
                _buildInstruction(
                  context,
                  'Diğer araç sürücüsüyle bilgi alışverişi yapın (isim, telefon, sigorta).',
                  Icons.contacts,
                ),
                _buildInstruction(
                  context,
                  'Kazanın ve hasarların fotoğraflarını çekin.',
                  Icons.photo_camera,
                ),
                _buildInstruction(
                  context,
                  'Mümkünse görgü tanıklarının iletişim bilgilerini alın.',
                  Icons.people,
                ),
                _buildInstruction(
                  context,
                  'Gerekirse trafik polisini çağırın ve kaza tespit tutanağı düzenletin.',
                  Icons.local_police,
                ),
                _buildInstruction(
                  context,
                  'En kısa sürede sigorta şirketinizi bilgilendirin.',
                  Icons.policy,
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
                      const Icon(Icons.contact_phone, color: Color(0xFF283593)),
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
                  _buildContactRow(context, 'Acil Çağrı Merkezi', '112'),
                  _buildContactRow(context, 'Trafik Polisi', '155'),
                  _buildContactRow(context, 'Yol Yardım', '159'),
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
            Icon(icon, color: const Color(0xFF283593), size: 24),
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
              color: const Color(0xFF283593).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF283593)),
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
                  color: const Color(0xFF283593),
                ),
          ),
        ],
      ),
    );
  }
}
