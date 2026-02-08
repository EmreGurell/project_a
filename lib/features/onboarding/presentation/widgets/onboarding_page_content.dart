import 'package:flutter/material.dart';
import 'package:project_a/features/onboarding/domain/models/onboarding_page.dart';
import 'package:project_a/utils/constants/colors.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnBoardingPage page;

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
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
            child: Column(
              children: [
                Text(
                  page.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  page.description,
                  style: const TextStyle(
                    fontSize: 16,
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
