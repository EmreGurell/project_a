import 'package:flutter/material.dart';
import 'package:project_a/shared/widgets/appbar/custom_app_bar.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Tarifler'),
      body: const Center(
        child: Text('Tarifler sayfası yakında...'),
      ),
    );
  }
}
