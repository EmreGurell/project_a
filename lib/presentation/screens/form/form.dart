import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_a/domain/entities/form/form_pages_data.dart';
import 'package:project_a/data/models/form/form_pages_model.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/constants/texts.dart';
import 'package:project_a/utils/device/device_utility.dart';

import '../../../shared/widgets/buttons/3d_button.dart';
import '../auth/login.dart';
import '../../widgets/form/form_page_content.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<FormPagesModel> get _pages => FormPagesData.pages;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: SizedBox(
          width: DeviceUtility.getScreenWidth(context) * 0.6,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: (_currentPage) / _pages.length,
              minHeight: ProjectSizes.spaceBtwItems,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(ProjectColors.orange),
            ),
          ),
        ),
        leading: IconButton(
          icon: PhosphorIcon(PhosphorIconsRegular.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.pagePadding,
          vertical: ProjectSizes.pagePadding * 2,
        ),
        child: Button3D(
          text: ProjectTexts.formNextButton,
          onPressed: _onNextPage,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) => FormPageContent(page: _pages[index]),
      ),
    );
  }
}
