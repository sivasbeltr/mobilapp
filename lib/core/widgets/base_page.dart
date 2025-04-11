import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../client/services/connectivity_service.dart';

/// Base page class that all pages should extend
/// Provides common functionality like offline mode check
class BasePage extends StatefulWidget {
  /// Page title shown in the app bar
  final String title;

  /// Whether this page can be accessed in offline mode
  final bool offlineAccessible;

  /// Parameters passed to the page (useful for deep links and notifications)
  final Map<String, dynamic>? parameters;

  /// Main body of the page
  final Widget body;

  /// Optional custom app bar
  final PreferredSizeWidget? appBar;

  /// Optional bottom navigation bar
  final Widget? bottomNavigationBar;

  /// Optional floating action button
  final Widget? floatingActionButton;

  /// Optional drawer
  final Widget? drawer;

  const BasePage({
    super.key,
    required this.title,
    required this.offlineAccessible,
    required this.body,
    this.parameters,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
  });

  @override
  State<BasePage> createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  /// Check if the device has internet connection
  /// If not and the page is not offline accessible, redirect to offline home
  void _checkConnectivity() async {
    final connectivityService = Provider.of<ConnectivityService>(
      context,
      listen: false,
    );
    final isConnected = await connectivityService.checkConnectivity();

    if (!isConnected && !widget.offlineAccessible && mounted) {
      Navigator.of(context).pushReplacementNamed('/offline-home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar ?? AppBar(title: Text(widget.title)),
      body: widget.body,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
      drawer: widget.drawer,
    );
  }
}
