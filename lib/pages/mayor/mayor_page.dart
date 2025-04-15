import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_colors.dart';
import '../show_image_full_page.dart';
import 'mayor_selections_page.dart';

class MayorPage extends StatefulWidget {
  const MayorPage({Key? key}) : super(key: key);

  @override
  State<MayorPage> createState() => _MayorPageState();
}

class _MayorPageState extends State<MayorPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarExpanded = false;
  final String _mayorImageUrl =
      'https://www.sivas.bel.tr/upload/personnel/dr-adem-uzun/dr-adem-uzun_8910.jpg';

  final List<String> _portraitImages = [
    'https://www.sivas.bel.tr/upload/files/portreler/portreler_7464.jpg',
    'https://www.sivas.bel.tr/upload/files/portreler/portreler_4732.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final expanded = _scrollController.offset < 200;
      if (_isAppBarExpanded != expanded) {
        setState(() {
          _isAppBarExpanded = expanded;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 300,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: theme.colorScheme.primary,
              flexibleSpace: FlexibleSpaceBar(
                title: AnimatedOpacity(
                  opacity: _isAppBarExpanded ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    'DR. ADEM UZUN- Belediye Başkanı',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'mayor_image',
                      child: GestureDetector(
                        onTap: () => _openFullScreenImage(context),
                        child: CachedNetworkImage(
                          imageUrl: _mayorImageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: theme.colorScheme.primary.withAlpha(50),
                            child: const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: theme.colorScheme.primary.withAlpha(50),
                            child: const Center(
                              child: Icon(Icons.error_outline,
                                  color: Colors.white, size: 48),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(150),
                          ],
                          stops: const [0.7, 1.0],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'DR. ADEM UZUN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(40),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'SİVAS BELEDİYE BAŞKANI',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSocialMediaLinks(context),
              const SizedBox(height: 24),
              _buildSelectionLink(theme),
              const SizedBox(height: 24),
              _buildPortraitGallery(context),
              const SizedBox(height: 24),
              _buildSection(context, 'Özgeçmiş', _buildBiography()),
              const SizedBox(height: 24),
              _buildSection(context, 'Başkanın Mesajı', _buildMayorMessage()),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaLinks(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withAlpha(40),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSocialMediaButton(
            context,
            FontAwesomeIcons.facebook,
            'https://www.facebook.com/drademuzun',
            Colors.blue.shade800,
          ),
          const SizedBox(width: 24),
          _buildSocialMediaButton(
            context,
            FontAwesomeIcons.instagram,
            'https://www.instagram.com/drademuzun',
            const Color(0xFFE1306C),
          ),
          const SizedBox(width: 24),
          _buildSocialMediaButton(
            context,
            FontAwesomeIcons.xTwitter,
            'https://x.com/drademuzun',
            Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaButton(
    BuildContext context,
    IconData icon,
    String url,
    Color color,
  ) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: color,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildSelectionLink(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MayorSelectionsPage(),
            ),
          );
        },
        style: TextButton.styleFrom(
          foregroundColor: theme.colorScheme.primary,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Başkandan Seçmeler'),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPortraitGallery(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Portreler',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _portraitImages.length,
              itemBuilder: (context, index) {
                return _buildPortraitItem(
                    context, _portraitImages[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortraitItem(BuildContext context, String imageUrl, int index) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GestureDetector(
          onTap: () => _openPortraitImage(context, imageUrl, index),
          child: Hero(
            tag: 'portrait_$index',
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey.withAlpha(50),
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey.withAlpha(50),
                child: const Icon(Icons.error_outline, size: 40),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openPortraitImage(BuildContext context, String imageUrl, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowImageFullPage(
          imageUrl: imageUrl,
          title: 'Portre ${index + 1}',
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildBiography() {
    const biographyText = '''
Sivas'ta 1980 yılında doğan Adem UZUN; İlköğrenimini Sivas'ta, Orta ve Lise Eğitimini Kayseri'de tamamladı. Sivas Cumhuriyet Üniversitesi Sosyal Bilgiler Öğretmenliği bölümünü bitiren Uzun, Yüksek Lisans ve Doktora eğitimlerini Gazi Üniversitesi Eğitim Bilimleri Enstitüsü'nde tamamladı.

2014-2022 yılları arasında Sivas Bilim ve Sanat Merkezinde (BİLSEM) Müdür olarak görev yapan Uzun, 2022 yılından itibaren Öğretim üyesi olarak görev yaptığı Sivas Cumhuriyet Üniversitesi Eğitim Fakültesi'nden 31 Mart Mahalli İdareler seçimleri için ayrılarak Sivas Belediye Başkanı seçildi. Uzun, iyi derecede İngilizce bilmekte olup, evli ve 2 çocuk babasıdır.
''';

    return Text(
      biographyText.trim(),
      style: const TextStyle(
        fontSize: 16,
        height: 1.6,
        color: Colors.black87,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildMayorMessage() {
    const messageText = '''
Tarihi, mazisi, kültürü ve eşsiz doğasıyla Anadolu'nun tam ortasında yer alan Selçuklu, Osmanlı ve Cumhuriyet kenti Sivas'ımıza hizmet edebilme imkanını bana ve ekibime veren kıymetli hemşehrilerim; sizlere vereceğim ilk mesajım emanetinize gözümüz gibi bakacağımız ve daha yaşanılabilir bir Sivas için geceli gündüzlü çalışacağımız olacaktır.

Şehrimizin problemlerini söz verdiğimiz gibi bir öncelik sırası gözeterek çözecek ve yeni dönemin sonunda daha müreffeh, daha kalkınmış ve daha mutlu bir şehrin temellerini bugünden atacağız. Yeni dönemle beraber yeni bir yönetim anlayışını da Sivas Belediyesi'nde hâkim kılacağız. Ortak akıl, istişare ve güçlü bir irade sonrası hızlı karar alabilen, çözüm odaklı ve insan merkezli bir yönetim şehrimizin önünü açacak ve bu anlayış projelerimizin de ivedilikle hayata geçirilmesine vesile olacaktır.

Öncelikli hedefimiz şehrimizin tüm renklerine sahip çıkarak, birlik ve bütünlük içerisinde ayrışmadan ve ayrıştırmadan "Hepimiz aynı kilimin desenleriyiz." düşüncesini önce yönetimimize ardından da tüm şehre hâkim kılmaktır. İşimiz çok, yolumuz uzundur… Allah, sizlerin teveccühü, teşviki ve duasıyla bismillah diyerek başladığımız yeni görevimizde başarılar nasip etsin. Hepinizi ayrı ayrı selamlıyor, saygı, sevgi ve muhabbetlerimi sunuyorum.
''';

    return Text(
      messageText.trim(),
      style: const TextStyle(
        fontSize: 16,
        height: 1.6,
        color: Colors.black87,
      ),
      textAlign: TextAlign.justify,
    );
  }

  void _openFullScreenImage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowImageFullPage(
          imageUrl: _mayorImageUrl,
          title: 'DR. ADEM UZUN',
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $urlString');
    }
  }
}
