import 'package:project_a/data/models/onboarding/onboarding_page_model.dart';
import 'package:project_a/utils/constants/image_paths.dart';
import 'package:project_a/utils/constants/texts.dart';

class OnboardingPagesData {
  OnboardingPagesData._();

  static const List<OnBoardingPageModel> pages = [
    OnBoardingPageModel(
      image: ImageAndAnimationPaths.onboarding1,
      title: ProjectTexts.onboardingTitle1,
      description: ProjectTexts.onboardingDesc1,
    ),
    OnBoardingPageModel(
      image: ImageAndAnimationPaths.onboarding2,
      title: ProjectTexts.onboardingTitle2,
      description: ProjectTexts.onboardingDesc2,
    ),
    OnBoardingPageModel(
      image: ImageAndAnimationPaths.onboarding3,
      title: ProjectTexts.onboardingTitle3,
      description: ProjectTexts.onboardingDesc3,
    ),
  ];
}
