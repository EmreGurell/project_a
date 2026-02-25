import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/core/router/route_names.dart';
import 'package:project_a/main.dart';
import 'package:project_a/utils/local_storage/storage_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Language',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<Locale>(
              valueListenable: appLocaleNotifier,
              builder: (context, locale, _) {
                return DropdownButtonFormField<String>(
                  value: locale.languageCode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'tr', child: Text('Turkce')),
                    DropdownMenuItem(value: 'en', child: Text('English')),
                  ],
                  onChanged: (value) async {
                    if (value == null) return;
                    appLocaleNotifier.value = Locale(value);
                    await sl<LocalStorageService>().saveLocaleCode(value);
                  },
                );
              },
            ),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
              ),
              onPressed: () async {
                await sl<LocalStorageService>().clearToken();
                if (!context.mounted) return;
                context.go(RouteNames.loginRoute);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
