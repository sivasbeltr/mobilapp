import 'package:flutter/material.dart';
import 'package:sivas_belediyesi/core/widgets/pages_app_bar.dart';

/// Detailed earthquake emergency instructions
class EarthquakePage extends StatelessWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const EarthquakePage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PagesAppBar(
        title: 'DEPREM',
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
                  Icons.terrain,
                  size: 80,
                  color: Color(0xFFC62828),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Introduction
            Text(
              'Deprem Anında Yapılması Gerekenler',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFC62828),
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Deprem sırasında sakin kalmak ve doğru davranışlarda bulunmak hayat kurtarır. Aşağıdaki talimatları mutlaka takip edin.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            // During earthquake section
            _buildSection(
              context,
              title: 'Deprem Sırasında',
              icon: Icons.access_time,
              instructions: [
                _buildInstruction(
                  context,
                  'Çök-Kapan-Tutun yöntemini uygulayın. Sağlam bir masa altına girin, başınızı ve boynunuzu koruyun.',
                  Icons.table_restaurant,
                ),
                _buildInstruction(
                  context,
                  'Pencerelerden, dış duvarlardan, aynalardan, asılı cisimlerden, kitaplıklardan ve yüksek mobilyalardan uzak durun.',
                  Icons.window,
                ),
                _buildInstruction(
                  context,
                  'Dışarıdaysanız, açık bir alana gidin ve binalardan, ağaçlardan, elektrik direklerinden uzak durun.',
                  Icons.park,
                ),
                _buildInstruction(
                  context,
                  'Araç kullanıyorsanız, aracınızı güvenli bir yere çekin ve içinde kalın.',
                  Icons.directions_car,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // After earthquake section
            _buildSection(
              context,
              title: 'Deprem Sonrası',
              icon: Icons.update,
              instructions: [
                _buildInstruction(
                  context,
                  'Etrafınızdaki insanlara yardım edin, yaralılar varsa ilk yardım uygulayın.',
                  Icons.medical_services,
                ),
                _buildInstruction(
                  context,
                  'Hasar görmüş binalardan uzak durun ve artçı sarsıntılara karşı dikkatli olun.',
                  Icons.home_work,
                ),
                _buildInstruction(
                  context,
                  'Gaz, su ve elektrik sistemlerini kontrol edin, hasar varsa ana vanalardan kapatın.',
                  Icons.devices_other,
                ),
                _buildInstruction(
                  context,
                  'Acil durum çantanızı yanınıza alın ve güvenli bir toplanma alanına gidin.',
                  Icons.backpack,
                ),
                _buildInstruction(
                  context,
                  'Sadece acil durumlar için telefonu kullanın, telefon hatlarını meşgul etmeyin.',
                  Icons.phone,
                ),
                _buildInstruction(
                  context,
                  'Yetkililerin yönergelerini radyo, TV veya resmî sosyal medya hesaplarından takip edin.',
                  Icons.campaign,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Preparation section
            _buildSection(
              context,
              title: 'Deprem Öncesi Hazırlık',
              icon: Icons.checklist,
              instructions: [
                _buildInstruction(
                  context,
                  'Acil durum çantası hazırlayın (su, yiyecek, ilk yardım malzemeleri, el feneri, pil, düdük, battaniye).',
                  Icons.inventory_2,
                ),
                _buildInstruction(
                  context,
                  'Evinizde güvenli ve tehlikeli alanları belirleyin, aile afet planı yapın.',
                  Icons.home,
                ),
                _buildInstruction(
                  context,
                  'Dolapları, kitaplıkları ve ağır eşyaları duvara sabitleyin.',
                  Icons.shelves,
                ),
                _buildInstruction(
                  context,
                  'Acil durum ve tahliye tatbikatları yapın.',
                  Icons.exit_to_app,
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
                border: Border.all(color: Colors.grey.withAlpha(76)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.contact_phone, color: Color(0xFFC62828)),
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
                  _buildContactRow(context, 'AFAD', '122'),
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
            Icon(icon, color: const Color(0xFFC62828), size: 24),
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
              color: const Color(0xFFC62828).withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: const Color(0xFFC62828)),
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
                  color: const Color(0xFFC62828),
                ),
          ),
        ],
      ),
    );
  }
}
