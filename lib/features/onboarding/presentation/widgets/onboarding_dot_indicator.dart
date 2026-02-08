import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';

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
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ProjectColors.orange,
        border: Border.all(color: ProjectColors.orange),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          pageCount,
          (index) => Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.only(right: index < pageCount - 1 ? 8 : 0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == index ? Colors.green : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
