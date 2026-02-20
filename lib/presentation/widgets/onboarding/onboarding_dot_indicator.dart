import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class OnboardingDotIndicator extends StatelessWidget {
  final int pageCount;
  final int currentIndex;

  const OnboardingDotIndicator({
    super.key,
    required this.pageCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(ProjectSizes.paddingSm),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          pageCount,
          (index) => Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.only(
              right: index < pageCount - 1 ? ProjectSizes.spaceBtwItems / 2 : 0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == index
                  ? ProjectColors.orange
                  : ProjectColors.gray,
            ),
          ),
        ),
      ),
    );
  }
}
