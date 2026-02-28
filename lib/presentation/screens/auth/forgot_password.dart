import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_a/common/bloc/button/button_state.dart';
import 'package:project_a/common/bloc/button/button_state_cubit.dart';
import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/core/errors/error_mapper.dart';
import 'package:project_a/core/router/route_names.dart';
import 'package:project_a/core/validation/form_validators.dart';
import 'package:project_a/data/models/auth/forgot_password_req_params.dart';
import 'package:project_a/domain/usecases/auth/forgot_password.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/presentation/widgets/auth/form_titles.dart';
import 'package:project_a/presentation/widgets/auth/shadowed_text_field.dart';
import 'package:project_a/shared/widgets/buttons/3d_button.dart';
import 'package:project_a/shared/widgets/snackbar/custom_snackbar.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/image_paths.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/device/device_utility.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (_) => sl<ButtonStateCubit>(),
        child: Stack(
          children: const [
            _ForgotBg(),
            _ForgotCard(),
            _ForgotMascot(),
          ],
        ),
      ),
    );
  }
}

class _ForgotBg extends StatelessWidget {
  const _ForgotBg();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      height: DeviceUtility.getScreenHeight(context) * 0.38,
      child: Image.asset(ImageAndAnimationPaths.authBg, fit: BoxFit.cover),
    );
  }
}

class _ForgotMascot extends StatelessWidget {
  const _ForgotMascot();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 20,
      height: DeviceUtility.getScreenHeight(context) * 0.38,
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
        child: Image.asset(
          ImageAndAnimationPaths.loginMascot,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _ForgotCard extends StatelessWidget {
  const _ForgotCard();

  @override
  Widget build(BuildContext context) {
    final screenHeight = DeviceUtility.getScreenHeight(context);
    return Positioned(
      left: 0,
      right: 0,
      top: screenHeight * 0.38 - 27,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: ProjectColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(ProjectSizes.authCardRadius),
            topRight: Radius.circular(ProjectSizes.authCardRadius),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              offset: const Offset(0, -4),
              blurRadius: 12,
            ),
          ],
        ),
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(ProjectSizes.pagePadding),
          child: _ForgotPasswordForm(),
        ),
      ),
    );
  }
}

class _ForgotPasswordForm extends StatefulWidget {
  const _ForgotPasswordForm();

  @override
  State<_ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<_ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  AppLocalizations get l10n => AppLocalizations.of(context)!;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ButtonStateCubit, ButtonState>(
      listener: (context, state) {
        if (state is ButtonSuccessState) {
          context.push(RouteNames.verifyAccountRoute, extra: {
            'email': _emailController.text.trim(),
            'isForReset': true,
          });
        }
        if (state is ButtonFailureState) {
          final mappedMessage =
              ErrorMapper.getErrorMessage(context, state.errorMessage);
          AppSnackbar.showError(context, message: mappedMessage);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormTitles(
              title: l10n.forgot_password_title,
              subtitle: l10n.forgot_password_subtitle,
            ),
            ShadowedTextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => FormValidators.email(value, l10n),
              decoration: InputDecoration(
                labelText: l10n.email,
                prefixIcon:
                    const PhosphorIcon(PhosphorIconsRegular.envelope),
              ),
            ),
            const SizedBox(height: ProjectSizes.spaceBtwSections),
            BlocBuilder<ButtonStateCubit, ButtonState>(
              builder: (context, state) {
                final isLoading = state is ButtonLoadingState;
                return Button3D(
                  text: l10n.forgot_password_send_code,
                  isLoading: isLoading,
                  loadingText: l10n.forgot_password_sending,
                  onPressed: () {
                    if (!(_formKey.currentState?.validate() ?? false)) {
                      return;
                    }
                    FocusScope.of(context).unfocus();
                    context.read<ButtonStateCubit>().execute(
                          usecase: sl<ForgotPasswordUseCase>(),
                          params: ForgotPasswordReqParam(
                            email: _emailController.text.trim(),
                          ),
                        );
                  },
                );
              },
            ),
            const SizedBox(height: ProjectSizes.spaceBtwItems),
            TextButton(
              onPressed: () => context.go(RouteNames.loginRoute),
              child: Text(
                l10n.back_to_login,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
