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
import 'package:project_a/data/models/auth/reset_password_req_params.dart';
import 'package:project_a/domain/usecases/auth/reset_password.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/presentation/widgets/auth/form_titles.dart';
import 'package:project_a/presentation/widgets/auth/shadowed_text_field.dart';
import 'package:project_a/shared/widgets/buttons/3d_button.dart';
import 'package:project_a/shared/widgets/snackbar/custom_snackbar.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/image_paths.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/device/device_utility.dart';

class ResetPasswordPage extends StatelessWidget {
  final String email;
  final String code;

  const ResetPasswordPage({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (_) => sl<ButtonStateCubit>(),
        child: Stack(
          children: [
            const _ResetBg(),
            const _ResetMascot(),
            _ResetCard(email: email, code: code),
          ],
        ),
      ),
    );
  }
}

class _ResetBg extends StatelessWidget {
  const _ResetBg();

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

class _ResetMascot extends StatelessWidget {
  const _ResetMascot();

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

class _ResetCard extends StatelessWidget {
  final String email;
  final String code;

  const _ResetCard({required this.email, required this.code});

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          child: _ResetPasswordForm(email: email, code: code),
        ),
      ),
    );
  }
}

class _ResetPasswordForm extends StatefulWidget {
  final String email;
  final String code;

  const _ResetPasswordForm({required this.email, required this.code});

  @override
  State<_ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<_ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isNewObscure = true;
  bool _isConfirmObscure = true;

  AppLocalizations get l10n => AppLocalizations.of(context)!;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ButtonStateCubit, ButtonState>(
      listener: (context, state) {
        if (state is ButtonSuccessState) {
          context.go(RouteNames.loginRoute);
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
              title: l10n.reset_password_title,
              subtitle: l10n.reset_password_subtitle,
            ),
            ShadowedTextField(
              controller: _newPasswordController,
              obscureText: _isNewObscure,
              validator: (value) => FormValidators.password(value, l10n),
              decoration: InputDecoration(
                labelText: l10n.reset_password_new_label,
                prefixIcon: const PhosphorIcon(PhosphorIconsRegular.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isNewObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () =>
                      setState(() => _isNewObscure = !_isNewObscure),
                ),
              ),
            ),
            const SizedBox(height: ProjectSizes.spaceBtwItems),
            ShadowedTextField(
              controller: _confirmPasswordController,
              obscureText: _isConfirmObscure,
              validator: (value) {
                final passwordError =
                    FormValidators.password(value, l10n);
                if (passwordError != null) return passwordError;
                if (value != _newPasswordController.text) {
                  return l10n.validation_passwords_not_match;
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: l10n.reset_password_confirm_label,
                prefixIcon: const PhosphorIcon(PhosphorIconsRegular.lockKey),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () =>
                      setState(() => _isConfirmObscure = !_isConfirmObscure),
                ),
              ),
            ),
            const SizedBox(height: ProjectSizes.spaceBtwSections),
            BlocBuilder<ButtonStateCubit, ButtonState>(
              builder: (context, state) {
                final isLoading = state is ButtonLoadingState;
                return Button3D(
                  text: l10n.reset_password_button,
                  isLoading: isLoading,
                  loadingText: l10n.reset_password_loading,
                  onPressed: () {
                    if (!(_formKey.currentState?.validate() ?? false)) {
                      return;
                    }
                    FocusScope.of(context).unfocus();
                    context.read<ButtonStateCubit>().execute(
                          usecase: sl<ResetPasswordUseCase>(),
                          params: ResetPasswordReqParam(
                            email: widget.email,
                            code: widget.code,
                            newPassword: _newPasswordController.text,
                          ),
                        );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
