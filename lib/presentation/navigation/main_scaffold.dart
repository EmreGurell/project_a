import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_a/presentation/navigation/app_bottom_navigation.dart';
import 'package:project_a/presentation/screens/barcode/barcode_scanner_page.dart';
import 'package:project_a/presentation/screens/cimbil/cimbil_page.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({required this.navigationShell, super.key});

  Future<void> _openBarcodeScanner(BuildContext context) async {
    final cameras = await availableCameras();
    if (cameras.isEmpty || !context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BarcodeScannerPage(camera: cameras.first),
      ),
    );
  }

  void _openCimbil(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CimbilPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        onAddTap: () => _openBarcodeScanner(context),
        onAITap: () => _openCimbil(context),
      ),
    );
  }
}