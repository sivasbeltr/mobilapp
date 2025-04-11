import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'client/services/connectivity_service.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        // Global services that need to be available throughout the app
        Provider<SharedPreferences>.value(value: sharedPreferences),
        ChangeNotifierProvider(create: (_) => ConnectivityService()),
      ],
      child: const App(),
    ),
  );
}
