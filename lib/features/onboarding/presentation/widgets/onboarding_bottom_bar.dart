import 'package:flutter/material.dart';
import 'package:project_a/features/onboarding/presentation/widgets/onboarding_dot_indicator.dart';
import 'package:project_a/utils/constants/colors.dart';

class OnboardingBottomBar extends StatelessWidget {
  final int pageCount;
  final int currentPage;
  final VoidCallback onNext;
  final VoidCallback? onSkip;

  const OnboardingBottomBar({
    super.key,
    required this.pageCount,
    required this.currentPage,
    required this.onNext,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OnboardingDotIndicator(
            pageCount: pageCount,
            currentIndex: currentPage,
          ),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: ProjectColors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(
              currentPage == pageCount - 1 ? 'Başlayalım' : 'İleri',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
