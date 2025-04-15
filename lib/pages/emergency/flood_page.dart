import 'package:flutter/material.dart';
import 'package:sivas_belediyesi/core/widgets/pages_app_bar.dart';

/// Detailed flood emergency instructions
class FloodPage extends StatelessWidget {
  /// Parameters passed from deep links or notifications
  final Map<String, dynamic>? parameters;

  const FloodPage({super.key, this.parameters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PagesAppBar(
        title: 'SEL',
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
                  Icons.tsunami,
                  size: 80,
                  color: Color(0xFF0277BD),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Introduction
            Text(
              'Sel ve Su Baskını Durumunda Yapılması Gerekenler',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0277BD),
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Sel ve su baskınları hızla gelişebilir. Bu durumlarda doğru davranışlarda bulunmak hayat kurtarır.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            // During flood section
            _buildSection(
              context,
              title: 'Sel Sırasında',
              icon: Icons.access_time,
              instructions: [
                _buildInstruction(
                  context,
                  'Hemen yüksek bir yere çıkın ve güvenli bir noktada kalın.',
                  Icons.terrain,
                ),
                _buildInstruction(
                  context,
                  'Asla sel suyunda yürümeye, yüzmeye veya araç kullanmaya çalışmayın.',
                  Icons.no_crash,
                ),
                _buildInstruction(
                  context,
                  'Elektrik kaynaklarından ve düşmüş elektrik hatlarından uzak durun.',
                  Icons.electrical_services,
                ),
                _buildInstruction(
                  context,
                  'Acil durum yetkililerinin talimatlarını takip edin.',
                  Icons.campaign,
                ),
                _buildInstruction(
                  context,
                  'Eğer araçtaysanız ve su yükseliyorsa, aracı terk edin ve yüksek bir yere çıkın.',
                  Icons.directions_car,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // After flood section
            _buildSection(
              context,
              title: 'Sel Sonrası',
              icon: Icons.update,
              instructions: [
                _buildInstruction(
                  context,
                  'Yetkililerin güvenli olduğunu bildirene kadar sel bölgesine geri dönmeyin.',
                  Icons.security,
                ),
                _buildInstruction(
                  context,
                  'Sel sularıyla temas etmiş yiyecekleri tüketmeyin.',
                  Icons.no_food,
                ),
                _buildInstruction(
                  context,
                  'Zarar görmüş tesisatları kullanmadan önce uzman kontrolünden geçirin.',
                  Icons.plumbing,
                ),
                _buildInstruction(
                  context,
                  'Sel sonrası hastalık riskine karşı kişisel hijyene özen gösterin.',
                  Icons.sanitizer,
                ),
                _buildInstruction(
                  context,
                  'Hasarları belgelemek için fotoğraflar çekin.',
                  Icons.photo_camera,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Preparation section
            _buildSection(
              context,
              title: 'Sel Öncesi Hazırlık',
              icon: Icons.checklist,
              instructions: [
                _buildInstruction(
                  context,
                  'Acil durum çantası ve su, yiyecek, ilaç gibi temel malzemeleri hazırlayın.',
                  Icons.backpack,
                ),
                _buildInstruction(
                  context,
                  'Sel riski olan alanlarda yaşıyorsanız, tahliye planını önceden belirleyin.',
                  Icons.map,
                ),
                _buildInstruction(
                  context,
                  'Su giderlerini ve çatı oluklarını düzenli olarak temizleyin.',
                  Icons.home,
                ),
                _buildInstruction(
                  context,
                  'Değerli eşyaları ve önemli belgeleri su geçirmez kaplarda saklayın.',
                  Icons.folder,
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
                      const Icon(Icons.contact_phone, color: Color(0xFF0277BD)),
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

  // Helper methods - similar to the earthquake page
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
            Icon(icon, color: const Color(0xFF0277BD), size: 24),
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
              color: const Color(0xFF0277BD).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF0277BD)),
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
                  color: const Color(0xFF0277BD),
                ),
          ),
        ],
      ),
    );
  }
}
