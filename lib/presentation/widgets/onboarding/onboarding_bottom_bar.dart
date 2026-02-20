import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/common/bloc/button/button_state_cubit.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/constants/texts.dart';

import '../../../core/di/service_locator.dart';
import '../../../shared/widgets/buttons/3d_button.dart';
import 'onboarding_dot_indicator.dart';


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
      padding: const EdgeInsets.symmetric(
        horizontal: ProjectSizes.pagePadding,
        vertical: ProjectSizes.pagePadding * 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OnboardingDotIndicator(
            pageCount: pageCount,
            currentIndex: currentPage,
          ),
          BlocProvider<ButtonStateCubit>(create: (context) => sl<ButtonStateCubit>(),
            child: Button3D(
              onPressed: onNext,
              text: currentPage == pageCount - 1
                  ? ProjectTexts.letsStart
                  : ProjectTexts.next,
            ),
          ),
        ],
      ),
    );
  }
}
