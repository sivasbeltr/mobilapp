/// Represents an item in the carousel on the home page.
class CarouselItem {
  /// The image URL of the carousel item.
  final String imageUrl;

  /// The title of the carousel item.
  final String title;

  /// The action to perform when the carousel item is tapped.
  final String? action;

  /// The ID associated with this carousel item.
  final String? id;

  /// Creates a new carousel item.
  const CarouselItem({
    required this.imageUrl,
    required this.title,
    this.action,
    this.id,
  });
}

/// Represents a service category on the home page.
class ServiceItem {
  /// The icon of the service.
  final String icon;

  /// The name of the service.
  final String name;

  /// The route to navigate to when the service is tapped.
  final String route;

  /// Creates a new service item.
  const ServiceItem({
    required this.icon,
    required this.name,
    required this.route,
  });
}

/// Represents a news item on the home page.
class NewsItem {
  /// The ID of the news item.
  final String id;

  /// The title of the news item.
  final String title;

  /// The image URL of the news item.
  final String imageUrl;

  /// The date of the news item.
  final String date;

  /// A brief summary of the news item.
  final String summary;

  /// Creates a new news item.
  const NewsItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.summary,
  });
}

/// Represents an event item on the home page.
class EventItem {
  /// The ID of the event.
  final String id;

  /// The title of the event.
  final String title;

  /// The image URL of the event.
  final String imageUrl;

  /// The date of the event.
  final String date;

  /// The location of the event.
  final String location;

  /// Creates a new event item.
  const EventItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.location,
  });
}

/// Manages the state of the home page.
class HomePageState {
  /// The items to display in the carousel.
  List<CarouselItem> carouselItems = [];

  /// The service categories to display.
  List<ServiceItem> services = [];

  /// The news items to display.
  List<NewsItem> news = [];

  /// The event items to display.
  List<EventItem> events = [];

  /// Whether the data is currently loading.
  bool isLoading = false;

  /// Any error that occurred during data loading.
  String? error;

  /// Initializes the home page state by loading necessary data.
  Future<void> initialize() async {
    isLoading = true;
    error = null;

    try {
      // In a real implementation, we would fetch from API
      // For demonstration, using dummy content with a delay
      await Future.delayed(const Duration(seconds: 1)); // Simulating API delay

      // Mock data for development
      _loadMockData();
    } catch (e) {
      error = 'Veri yüklenirken bir hata oluştu: $e';
    } finally {
      isLoading = false;
    }
  }

  /// Loads mock data for development.
  void _loadMockData() {
    // Mock carousel items
    carouselItems = [
      const CarouselItem(
        imageUrl: 'assets/images/sivas_placeholder.jpg',
        title: 'Cumhuriyet\'in Doğduğu Şehir',
        action: 'explore',
      ),
      const CarouselItem(
        imageUrl: 'assets/images/sivas_placeholder.jpg',
        title: '2024-2029 Vizyon Projelerimiz',
        action: 'projects',
      ),
      const CarouselItem(
        imageUrl: 'assets/images/sivas_placeholder.jpg',
        title: 'Şehrimizin Tarihi ve Kültürel Zenginlikleri',
        action: 'culture',
      ),
    ];

    // Enhanced mock service categories
    services = [
      const ServiceItem(
        icon: 'business',
        name: 'Kurumsal',
        route: '/kurumsal',
      ),
      const ServiceItem(
        icon: 'account_balance',
        name: 'Projeler',
        route: '/projeler',
      ),
      const ServiceItem(
        icon: 'event',
        name: 'Etkinlikler',
        route: '/etkinlikler',
      ),
      const ServiceItem(
        icon: 'announcement',
        name: 'Duyurular',
        route: '/duyurular',
      ),
      const ServiceItem(
        icon: 'library_books',
        name: 'İhaleler',
        route: '/ihaleler',
      ),
      const ServiceItem(
        icon: 'public',
        name: 'Sivas',
        route: '/sivas',
      ),
      const ServiceItem(
        icon: 'local_parking',
        name: 'Otopark',
        route: '/otopark',
      ),
      const ServiceItem(
        icon: 'water',
        name: 'Su İşleri',
        route: '/su-isleri',
      ),
      const ServiceItem(
        icon: 'construction',
        name: 'İmar',
        route: '/imar',
      ),
      const ServiceItem(
        icon: 'payments',
        name: 'Vergi ve Ödemeler',
        route: '/odemeler',
      ),
      const ServiceItem(
        icon: 'local_activity',
        name: 'Sosyal Tesisler',
        route: '/sosyal-tesisler',
      ),
      const ServiceItem(
        icon: 'contact_mail',
        name: 'İletişim',
        route: '/iletisim',
      ),
    ];

    // Enhanced mock news items
    news = [
      const NewsItem(
        id: '1',
        title: 'Belediyemiz Yeni Hizmet Binası Açıldı',
        imageUrl: 'assets/images/sivas_placeholder.jpg',
        date: '15.07.2023',
        summary:
            'Belediyemizin yeni hizmet binası düzenlenen törenle hizmete açıldı.',
      ),
      const NewsItem(
        id: '2',
        title: 'Şehrimizde Yol Çalışmaları Devam Ediyor',
        imageUrl: 'assets/images/sivas_placeholder.jpg',
        date: '10.07.2023',
        summary:
            'Merkez mahallelerinde başlatılan yol yapım ve onarım çalışmaları devam ediyor.',
      ),
      const NewsItem(
        id: '3',
        title: 'Engelsiz Yaşam Merkezi Projesi Hayata Geçiyor',
        imageUrl: 'assets/images/sivas_placeholder.jpg',
        date: '05.07.2023',
        summary:
            'Engelli vatandaşlarımızın hayatını kolaylaştıracak yeni merkezimiz için temel atma töreni gerçekleştirildi.',
      ),
    ];

    // Enhanced mock event items
    events = [
      const EventItem(
        id: '1',
        title: 'Sivas Kültür ve Sanat Festivali',
        imageUrl: 'assets/images/sivas_placeholder.jpg',
        date: '01.08.2023 - 05.08.2023',
        location: 'Sivas Kent Meydanı',
      ),
      const EventItem(
        id: '2',
        title: 'Yaz Konserleri Serisi',
        imageUrl: 'assets/images/sivas_placeholder.jpg',
        date: '15.08.2023',
        location: 'Atatürk Kültür Merkezi',
      ),
      const EventItem(
        id: '3',
        title: 'Sivas Kitap Fuarı',
        imageUrl: 'assets/images/sivas_placeholder.jpg',
        date: '20.08.2023 - 27.08.2023',
        location: 'Fuar ve Kongre Merkezi',
      ),
      const EventItem(
        id: '4',
        title: 'Geleneksel El Sanatları Sergisi',
        imageUrl: 'assets/images/sivas_placeholder.jpg',
        date: '10.09.2023 - 15.09.2023',
        location: 'Tarihi Sivas Konağı',
      ),
    ];
  }
}
