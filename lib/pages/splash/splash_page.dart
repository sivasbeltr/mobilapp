import 'package:flutter/material.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/services/notification_message.dart';
import '../home/home_page.dart';
import '../home/offline_home_page.dart';

/// SplashPage is the initial screen displayed when the app launches.
/// It features a modern, elegant UI with smooth animations, handling connectivity checks and notification/deeplink routing.
class SplashPage extends StatefulWidget {
  /// Creates a new [SplashPage].
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final ConnectivityService _connectivityService = ConnectivityService();
  late AnimationController _animationController;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _loaderFadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Define animations
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
      ),
    );

    _loaderFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    // Start animation
    _animationController.forward();

    // Initialize app logic
    _initialize();
  }

  /// Initializes the app and handles navigation.
  Future<void> _initialize() async {
    // Wait for animation to complete for better UX
    await Future.delayed(const Duration(milliseconds: 2500));

    // Make sure we're still mounted before proceeding
    if (!mounted) return;

    // Check internet connectivity
    final bool hasConnection =
        await _connectivityService.hasInternetConnection();

    // Navigate based on connectivity
    if (!mounted) return;
    if (hasConnection) {
      _navigateToHome();
    } else {
      _navigateToOfflineHome();
    }
  }

  /// Navigates to the home page, handling any notification or deeplink.
  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );

    // Handle notification after navigating to HomePage
    _handleNotificationIfPresent();
  }

  /// Navigates to the offline home page.
  void _navigateToOfflineHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OfflineHomePage()),
    );
  }

  /// Handles any pending notification or deeplink.
  void _handleNotificationIfPresent() {
    final notification = NotificationMessage.current;
    if (notification == null) return;

    // Clear the notification to prevent handling it multiple times
    NotificationMessage.clear();
    // Add navigation logic in main.dart as needed
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Gradient background with softer colors
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A5B96), // Softer blue tone
                  Color(0xFF3172B2), // Lighter blue tone
                ],
              ),
            ),
          ),
          // Main content - more compact layout
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated logo with scale and fade
                FadeTransition(
                  opacity: _logoFadeAnimation,
                  child: ScaleTransition(
                    scale: _logoScaleAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/belediye_logo.png',
                        width: 160, // Smaller logo size
                        height: 160,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Reduced spacing
                // Animated municipality name with smaller typography
                FadeTransition(
                  opacity: _textFadeAnimation,
                  child: const Text(
                    'Sivas Belediyesi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28, // Smaller font size
                      fontFamily: 'Roboto', // As specified in instructions
                      fontWeight: FontWeight.w600, // Slightly lighter weight
                      letterSpacing: 0.8, // Less spacing
                      shadows: [
                        Shadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Reduced spacing
                // Improved loading indicator
                FadeTransition(
                  opacity: _loaderFadeAnimation,
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Tagline with improved styling
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24), // Less padding
              child: FadeTransition(
                opacity: _textFadeAnimation,
                child: const Text(
                  'Sivas a Hizmet, Bizim Gururumuz',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16, // Smaller font size
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2, // Less spacing
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
