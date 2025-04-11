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
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Sivas Municipality Logo
                Image.asset(
                  'assets/images/belediye_logo.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 24),
                Text(
                  'Sivas Belediyesi',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 48),
                const CircularProgressIndicator(color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
