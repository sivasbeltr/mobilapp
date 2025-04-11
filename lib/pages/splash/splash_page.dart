import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../client/services/connectivity_service.dart';
import '../../core/utils/navigation_service.dart';

/// Splash screen that appears on app launch
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();

    // Initialize app data and check connectivity
    _initializeApp();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Initialize app data and navigate to appropriate screen
  Future<void> _initializeApp() async {
    // Simulate loading time or fetch initial data
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      // Check connectivity
      final connectivityService = Provider.of<ConnectivityService>(
        context,
        listen: false,
      );
      final isConnected = await connectivityService.checkConnectivity();

      // Navigate to appropriate screen based on connectivity
      if (isConnected) {
        NavigationService.replaceTo(NavigationService.home);
      } else {
        NavigationService.replaceTo(NavigationService.offlineHome);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with shadow effect
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20.0,
                        spreadRadius: 3.0,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        'assets/images/belediye_logo.png',
                        width: 160,
                        height: 160,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Sivas Belediyesi',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hizmetinizde',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 50),
                // Simple loading indicator
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
