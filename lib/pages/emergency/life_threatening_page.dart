import 'package:flutter/material.dart';
import 'package:sivas_belediyesi/core/widgets/pages_app_bar.dart';

/// Detailed life-threatening emergency instructions
class LifeThreateningPage extends StatelessWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const LifeThreateningPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PagesAppBar(
        title: 'HAYATİ TEHLİKE',
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
                  Icons.health_and_safety,
                  size: 80,
                  color: Color(0xFFD81B60),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Introduction
            Text(
              'Acil Müdahale Gerektiren Durumlar',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFD81B60),
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Bu durumlarda hızlı müdahale hayat kurtarır. Hemen 112\'yi arayın ve aşağıdaki talimatlara göre hareket edin.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            // Heart attack section
            _buildSection(
              context,
              title: 'Kalp Krizi',
              icon: Icons.favorite_border,
              instructions: [
                _buildInstruction(
                  context,
                  'Göğüs ortasında baskı, sıkışma veya ağrı, çene, boyun ve kollara yayılabilen ağrı belirtileridir.',
                  Icons.heart_broken,
                ),
                _buildInstruction(
                  context,
                  'Kişiyi rahat bir pozisyona getirin, yarı oturur pozisyon tercih edilir.',
                  Icons.airline_seat_recline_normal,
                ),
                _buildInstruction(
                  context,
                  'Sıkı giysileri gevşetin ve taze hava almasını sağlayın.',
                  Icons.air,
                ),
                _buildInstruction(
                  context,
                  'Eğer varsa ve alerjisi yoksa bir aspirin çiğnetebilirsiniz.',
                  Icons.medication,
                ),
                _buildInstruction(
                  context,
                  'Bilinci kapanırsa ve nefes almıyorsa hemen CPR\'a başlayın.',
                  Icons.health_and_safety,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Stroke section
            _buildSection(
              context,
              title: 'İnme (Felç)',
              icon: Icons.psychology,
              instructions: [
                _buildInstruction(
                  context,
                  'FAST metodu ile kontrol edin - Yüz (Face): Yüzde sarkma var mı?',
                  Icons.face,
                ),
                _buildInstruction(
                  context,
                  'Kollar (Arms): Kişi her iki kolunu eşit kaldırabiliyor mu?',
                  Icons.pan_tool,
                ),
                _buildInstruction(
                  context,
                  'Konuşma (Speech): Konuşma bozukluğu var mı?',
                  Icons.record_voice_over,
                ),
                _buildInstruction(
                  context,
                  'Zaman (Time): Bu belirtiler varsa acilen 112\'yi arayın.',
                  Icons.access_time,
                ),
                _buildInstruction(
                  context,
                  'Kişiyi rahat bir pozisyona getirin ve bilincini takip edin.',
                  Icons.accessibility_new,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Choking section
            _buildSection(
              context,
              title: 'Boğulma / Yabancı Cisim',
              icon: Icons.coronavirus,
              instructions: [
                _buildInstruction(
                  context,
                  'Kişi öksürebiliyorsa, öksürmeye teşvik edin. Öksürük en etkili yöntemdir.',
                  Icons.run_circle,
                ),
                _buildInstruction(
                  context,
                  'Tam tıkanıklık varsa (konuşamıyor, nefes alamıyor, öksüremiyor) Heimlich manevrası uygulayın.',
                  Icons.back_hand,
                ),
                _buildInstruction(
                  context,
                  'Kişinin arkasında durun, bir elinizi yumruk yapıp başparmak tarafı karnına gelecek şekilde göbek ile göğüs kafesi arasına yerleştirin.',
                  Icons.transfer_within_a_station,
                ),
                _buildInstruction(
                  context,
                  'Diğer elinizle yumruğunuzu kavrayıp, hızlı bir şekilde içeri ve yukarı doğru baskı uygulayın.',
                  Icons.vertical_align_top,
                ),
                _buildInstruction(
                  context,
                  'Kişi bayılırsa, yere yatırın ve CPR uygulamaya başlayın.',
                  Icons.personal_injury,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Severe allergic reaction section
            _buildSection(
              context,
              title: 'Ciddi Alerjik Reaksiyon',
              icon: Icons.warning_amber,
              instructions: [
                _buildInstruction(
                  context,
                  'Ani şişlik, döküntü, nefes alma zorluğu, dudak/dil şişmesi anafilaksi belirtileridir.',
                  Icons.sick,
                ),
                _buildInstruction(
                  context,
                  'Eğer kişinin epinefrin oto-enjektörü (EpiPen) varsa kullanmasına yardım edin.',
                  Icons.vaccines,
                ),
                _buildInstruction(
                  context,
                  'Kişiyi yarı oturur pozisyonda tutun, sıkı giysileri gevşetin.',
                  Icons.airline_seat_legroom_extra,
                ),
                _buildInstruction(
                  context,
                  'Solunum zorluğu veya bilinç kaybı varsa, CPR başlatmaya hazır olun.',
                  Icons.medical_services,
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
                      const Icon(Icons.contact_phone, color: Color(0xFFD81B60)),
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
                  _buildContactRow(context, 'Zehir Danışma', '114'),
                  _buildContactRow(context, 'Sağlık Danışma', '184'),
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
            Icon(icon, color: const Color(0xFFD81B60), size: 24),
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
              color: const Color(0xFFD81B60).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: const Color(0xFFD81B60)),
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
                  color: const Color(0xFFD81B60),
                ),
          ),
        ],
      ),
    );
  }
}
