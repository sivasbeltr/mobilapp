import 'package:flutter/material.dart';
import 'package:sivas_belediyesi/core/widgets/pages_app_bar.dart';

/// Detailed first aid emergency instructions
class FirstAidPage extends StatelessWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const FirstAidPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PagesAppBar(
        title: 'İLK YARDIM',
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
                  Icons.medical_services,
                  size: 80,
                  color: Color(0xFF00695C),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Introduction
            Text(
              'Temel İlk Yardım Bilgileri',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF00695C),
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Acil durumlarda doğru ilk yardım uygulamaları hayat kurtarabilir. Her durumda sakin kalın ve profesyonel yardım çağırın.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            // Basic principles
            _buildSection(
              context,
              title: 'Temel İlk Yardım İlkeleri',
              icon: Icons.medical_information,
              instructions: [
                _buildInstruction(
                  context,
                  'Önce kendi güvenliğinizi sağlayın, sonra yardım edin.',
                  Icons.security,
                ),
                _buildInstruction(
                  context,
                  'Acil yardım hattını (112) arayın veya birinden aramasını isteyin.',
                  Icons.call,
                ),
                _buildInstruction(
                  context,
                  'Yaralının bilinci açık mı, nefes alıyor mu kontrol edin.',
                  Icons.health_and_safety,
                ),
                _buildInstruction(
                  context,
                  'Hayati tehlikesi yoksa, yaralıyı gereksiz yere hareket ettirmeyin.',
                  Icons.do_not_disturb,
                ),
                _buildInstruction(
                  context,
                  'Sakin kalın ve panik yapmayın.',
                  Icons.psychology,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // CPR section
            _buildSection(
              context,
              title: 'Temel Yaşam Desteği (CPR)',
              icon: Icons.favorite,
              instructions: [
                _buildInstruction(
                  context,
                  'Bilinci kapalı ve normal nefes almayan kişide CPR uygulanmalıdır.',
                  Icons.airline_seat_flat,
                ),
                _buildInstruction(
                  context,
                  'Göğüs kemiği üzerine ellerinizi yerleştirin ve sert bir yüzeyde göğsü 5-6 cm çöktürecek şekilde bastırın.',
                  Icons.accessibility,
                ),
                _buildInstruction(
                  context,
                  'Dakikada 100-120 baskı hızında ritimli olarak CPR uygulayın.',
                  Icons.speed,
                ),
                _buildInstruction(
                  context,
                  'Mümkünse 30 göğüs baskısından sonra 2 suni solunum uygulayın.',
                  Icons.air,
                ),
                _buildInstruction(
                  context,
                  'Yardım gelene veya kişi tepki verene kadar devam edin.',
                  Icons.timer,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Bleeding section
            _buildSection(
              context,
              title: 'Kanama Kontrolü',
              icon: Icons.bloodtype,
              instructions: [
                _buildInstruction(
                  context,
                  'Temiz bir bez veya gazlı bezle kanayan bölgeye doğrudan baskı uygulayın.',
                  Icons.healing,
                ),
                _buildInstruction(
                  context,
                  'Mümkünse kanayan bölgeyi kalp seviyesinden yukarıda tutun.',
                  Icons.height,
                ),
                _buildInstruction(
                  context,
                  'Baskı bandajı uygulayın ve baskıyı sürdürün.',
                  Icons.cached,
                ),
                _buildInstruction(
                  context,
                  'Turnike kullanımı sadece ekstrem durumlarda ve son çare olmalıdır.',
                  Icons.warning,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Burns section
            _buildSection(
              context,
              title: 'Yanıklar',
              icon: Icons.whatshot,
              instructions: [
                _buildInstruction(
                  context,
                  'Yanık bölgesini 10-20 dakika soğuk (buzlu değil) suyun altında tutun.',
                  Icons.water,
                ),
                _buildInstruction(
                  context,
                  'Yanık üzerindeki giysiler yapışmamışsa nazikçe çıkarın.',
                  Icons.dry_cleaning,
                ),
                _buildInstruction(
                  context,
                  'Yanığı temiz bir bezle örtün, asla krem, yağ veya ev ilacı sürmeyin.',
                  Icons.do_not_touch,
                ),
                _buildInstruction(
                  context,
                  'Ciddi yanıklarda mutlaka tıbbi yardım alın.',
                  Icons.local_hospital,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Fractures section
            _buildSection(
              context,
              title: 'Kırıklar ve Burkulmalar',
              icon: Icons.fitness_center,
              instructions: [
                _buildInstruction(
                  context,
                  'Yaralı bölgeyi hareket ettirmeyin ve stabilize edin.',
                  Icons.pan_tool,
                ),
                _buildInstruction(
                  context,
                  'Şişliği azaltmak için soğuk kompres uygulayın.',
                  Icons.ac_unit,
                ),
                _buildInstruction(
                  context,
                  'Açık kırıklarda kanamaları kontrol edin ve yarayı temiz tutun.',
                  Icons.clean_hands,
                ),
                _buildInstruction(
                  context,
                  'Profesyonel yardım gelene kadar uygun şekilde sabitleyin.',
                  Icons.front_hand,
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
                      const Icon(Icons.contact_phone, color: Color(0xFF00695C)),
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
                  _buildContactRow(context, 'Sağlık Danışma', '184'),
                  _buildContactRow(context, 'Zehir Danışma', '114'),
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
            Icon(icon, color: const Color(0xFF00695C), size: 24),
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
              color: const Color(0xFF00695C).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF00695C)),
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
                  color: const Color(0xFF00695C),
                ),
          ),
        ],
      ),
    );
  }
}
