import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/navigation_service.dart';
import 'pages/splash/splash_page.dart';
import 'pages/emergency/emergency_page.dart';
import 'pages/transportation/transportation_page.dart';
import 'pages/send_check/send_check_page.dart';
import 'pages/marriage/marriage_page.dart';
import 'pages/contact/contact_page.dart';
import 'pages/complaints/complaints_page.dart';
import 'pages/water/water_page.dart';
import 'pages/pharmacy/pharmacy_page.dart';
import 'pages/emergency/earthquake_page.dart';

/// The main application widget.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // Add other providers here as needed
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sivas Belediyesi',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            navigatorKey: NavigationService.navigatorKey,
            onGenerateRoute: NavigationService.onGenerateRoute,
            home: const SplashPage(),
            routes: {
              // ...existing routes...
              NavigationService.emergency: (context) => const EmergencyPage(),
              NavigationService.transportation:
                  (context) => const TransportationPage(),
              NavigationService.sendCheck: (context) => const SendCheckPage(),
              NavigationService.marriage: (context) => const MarriagePage(),
              NavigationService.contact: (context) => const ContactPage(),
              NavigationService.complaints: (context) => const ComplaintsPage(),
              NavigationService.water: (context) => const WaterPage(),
              NavigationService.pharmacy: (context) => const PharmacyPage(),
              NavigationService.earthquakeEmergency:
                  (context) => const EarthquakePage(),
            },
          );
        },
      ),
    );
  }
}
