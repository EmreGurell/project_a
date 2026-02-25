import 'package:flutter/material.dart';
import 'package:project_a/shared/widgets/appbar/custom_app_bar.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Topluluk'),
      body: const Center(
        child: Text('Topluluk sayfası yakında...'),
      ),
    );
  }
}
