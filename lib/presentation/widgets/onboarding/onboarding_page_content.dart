import 'package:flutter/material.dart';
import 'package:project_a/data/models/onboarding/onboarding_page_model.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnBoardingPageModel page;

  const OnboardingPageContent({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            page.image,
            height:
                MediaQuery.of(context).size.height *
                ProjectSizes.onboardingImageHeightFraction,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: ProjectSizes.onboardingLargeSpacing),
          Padding(
            padding: const EdgeInsets.only(
              bottom: ProjectSizes.onboardingPadding,
              left: ProjectSizes.onboardingPadding,
              right: ProjectSizes.onboardingPadding,
            ),
            child: Column(
              children: [
                Text(
                  page.title,
                  style: TextStyle(
                    fontSize: ProjectSizes.onboardingTitleFontSize,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: ProjectSizes.onboardingTitleSpacing),
                Text(
                  page.description,
                  style: TextStyle(
                    fontSize: ProjectSizes.onboardingDescFontSize,
                    fontWeight: FontWeight.w400,
                    color: ProjectColors.textGray,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
