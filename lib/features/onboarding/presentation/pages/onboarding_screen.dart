import 'package:flutter/material.dart';
import 'package:project_a/features/auth/login/screens/login.dart';
import 'package:project_a/features/onboarding/domain/data/onboarding_pages_data.dart';
import 'package:project_a/features/onboarding/domain/models/onboarding_page.dart';
import 'package:project_a/features/onboarding/presentation/widgets/onboarding_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnBoardingPage> get _pages => OnboardingPagesData.pages;

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
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) =>
                OnboardingPageContent(page: _pages[index]),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: OnboardingSkipButton(onPressed: _completeOnboarding),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: OnboardingBottomBar(
              pageCount: _pages.length,
              currentPage: _currentPage,
              onNext: _onNextPage,
            ),
          ),
        ],
      ),
    );
  }
}
