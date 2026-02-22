import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_a/core/router/route_names.dart';
import 'package:project_a/data/models/onboarding/onboarding_page_model.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/presentation/widgets/onboarding/onboarding_bottom_bar.dart';
import 'package:project_a/utils/constants/image_paths.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/device/device_utility.dart';
import '../../../common/bloc/app_entry/app_entry_state_cubit.dart';
import '../../widgets/onboarding/onboarding_page_content.dart';
import '../../widgets/onboarding/onboarding_skip_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  AppLocalizations get l10n => AppLocalizations.of(context)!;

  int _currentPage = 0;

  List<OnBoardingPageModel> get _pages => [
    OnBoardingPageModel(
      image: ImageAndAnimationPaths.onboarding1,
      title: l10n.onboarding_title_1,
      description: l10n.onboarding_desc_1,
    ),
    OnBoardingPageModel(
      image: ImageAndAnimationPaths.onboarding2,
      title: l10n.onboarding_title_2,
      description: l10n.onboarding_desc_2,
    ),
    OnBoardingPageModel(
      image: ImageAndAnimationPaths.onboarding3,
      title: l10n.onboarding_title_3,
      description: l10n.onboarding_desc_3,
    ),
  ];

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

  void _completeOnboarding() async {
    await context.read<AppEntryCubit>().completeOnboarding();
    if (!mounted) return;
    context.go(RouteNames.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: OnboardingBottomBar(
        pageCount: _pages.length,
        currentPage: _currentPage,
        onNext: _onNextPage,
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) => OnboardingPageContent(
              page: _pages[index],
              title: ProjectSizes.onboardingTitleFontSize,
              description: ProjectSizes.onboardingDescFontSize,
            ),
          ),
          Positioned(
            top:
                DeviceUtility.getStatusBarHeight(context) +
                ProjectSizes.pagePadding,
            right: ProjectSizes.pagePadding,
            child: OnboardingSkipButton(
              onPressed: _completeOnboarding,
              text: l10n.onboarding_skip,
            ),
          ),
        ],
      ),
    );
  }
}
