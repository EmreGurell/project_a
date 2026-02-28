import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_a/core/router/route_names.dart';
import 'package:project_a/domain/entities/form/form_pages_data.dart';
import 'package:project_a/data/models/form/form_pages_model.dart';
import 'package:project_a/presentation/bloc/form/profile_setup_bloc.dart';
import 'package:project_a/presentation/bloc/form/profile_setup_event.dart';
import 'package:project_a/presentation/bloc/form/profile_setup_state.dart';
import 'package:project_a/shared/widgets/snackbar/custom_snackbar.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/constants/texts.dart';
import 'package:project_a/utils/device/device_utility.dart';

import '../../../shared/widgets/buttons/3d_button.dart';
import '../../widgets/form/form_page_content.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late PageController _pageController;
  bool _controllerReady = false;

  List<FormPagesModel> get _pages => FormPagesData.pages;

  @override
  void dispose() {
    if (_controllerReady) _pageController.dispose();
    super.dispose();
  }

  void _initController(int initialPage) {
    if (!_controllerReady) {
      _pageController = PageController(initialPage: initialPage);
      _controllerReady = true;
    }
  }

  void _onNextPage(ProfileSetupInProgress state) {
    final currentPage = state.currentPage;
    if (currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.read<ProfileSetupBloc>().add(SubmitForm());
    }
  }

  void _onPreviousPage(int currentPage) {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileSetupBloc, ProfileSetupState>(
      listener: (context, state) {
        if (state is ProfileSetupSuccess) {
          context.go(RouteNames.homeRoute);
        }
        if (state is ProfileSetupFailure) {
          AppSnackbar.showError(context, message: state.message);
        }
      },
      builder: (context, state) {
        if (state is ProfileSetupInitial) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final inProgress = state as ProfileSetupInProgress;
        _initController(inProgress.currentPage);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: SizedBox(
              width: DeviceUtility.getScreenWidth(context) * 0.6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: inProgress.currentPage / _pages.length,
                  minHeight: ProjectSizes.spaceBtwItems,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(ProjectColors.orange),
                ),
              ),
            ),
            leading: IconButton(
              icon: PhosphorIcon(PhosphorIconsRegular.arrowLeft),
              onPressed: () => _onPreviousPage(inProgress.currentPage),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: ProjectSizes.pagePadding,
              vertical: ProjectSizes.pagePadding * 2,
            ),
            child: Button3D(
              text: ProjectTexts.formNextButton,
              isLoading: inProgress.isSubmitting,
              onPressed: () => _onNextPage(inProgress),
            ),
          ),
          body: PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              context.read<ProfileSetupBloc>().add(FormPageChanged(index));
            },
            itemBuilder: (context, index) {
              final page = _pages[index];
              final answer = inProgress.answers[page.fieldKey];
              final answer2 = inProgress.answers[page.fieldKey2 ?? ''];
              return FormPageContent(
                page: page,
                currentAnswer: answer,
                currentAnswer2: answer2,
                onAnswerChanged: (key, value) {
                  context.read<ProfileSetupBloc>().add(AnswerUpdated(key, value));
                },
              );
            },
          ),
        );
      },
    );
  }
}
