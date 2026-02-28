import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_a/common/bloc/button/button_state.dart';
import 'package:project_a/common/bloc/button/button_state_cubit.dart';
import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/core/errors/error_mapper.dart';
import 'package:project_a/core/router/route_names.dart';
import 'package:project_a/data/models/auth/resend_verification_req_params.dart';
import 'package:project_a/data/models/auth/verify_account_req_params.dart';
import 'package:project_a/domain/usecases/auth/resend_verification_code.dart';
import 'package:project_a/domain/usecases/auth/verify_account.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/presentation/widgets/auth/form_titles.dart';
import 'package:project_a/presentation/widgets/auth/shadowed_text_field.dart';
import 'package:project_a/shared/widgets/buttons/3d_button.dart';
import 'package:project_a/shared/widgets/snackbar/custom_snackbar.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/image_paths.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/device/device_utility.dart';

class VerifyAccountPage extends StatelessWidget {
  final String email;

  /// true  → şifre sıfırlama akışından gelindi (kodu gir → reset password)
  /// false → kayıt sonrası hesap doğrulama (kodu gir → home)
  final bool isForReset;

  const VerifyAccountPage({
    super.key,
    required this.email,
    this.isForReset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (_) => sl<ButtonStateCubit>(),
        child: Stack(
          children: [
            const _VerifyBg(),
            const _VerifyMascot(),
            _VerifyCard(email: email, isForReset: isForReset),
          ],
        ),
      ),
    );
  }
}

class _VerifyBg extends StatelessWidget {
  const _VerifyBg();

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

class _VerifyMascot extends StatelessWidget {
  const _VerifyMascot();

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

class _VerifyCard extends StatelessWidget {
  final String email;
  final bool isForReset;

  const _VerifyCard({required this.email, required this.isForReset});

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
          child: _VerifyAccountForm(email: email, isForReset: isForReset),
        ),
      ),
    );
  }
}

class _VerifyAccountForm extends StatefulWidget {
  final String email;
  final bool isForReset;

  const _VerifyAccountForm({
    required this.email,
    required this.isForReset,
  });

  @override
  State<_VerifyAccountForm> createState() => _VerifyAccountFormState();
}

class _VerifyAccountFormState extends State<_VerifyAccountForm> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _isResending = false;

  AppLocalizations get l10n => AppLocalizations.of(context)!;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  String? _validateCode(String? value) {
    final code = value?.trim() ?? '';
    if (code.isEmpty) return l10n.validation_code_required;
    if (code.length != 6) return l10n.validation_code_length;
    return null;
  }

  Future<void> _resendCode() async {
    setState(() => _isResending = true);
    try {
      final result = await sl<ResendVerificationCodeUseCase>().call(
        param: ResendVerificationReqParam(email: widget.email),
      );
      result.fold(
        (error) {
          if (mounted) {
            final msg = ErrorMapper.getErrorMessage(context, error);
            AppSnackbar.showError(context, message: msg);
          }
        },
        (_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.verify_account_resend)),
            );
          }
        },
      );
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ButtonStateCubit, ButtonState>(
      listener: (context, state) {
        if (state is ButtonSuccessState) {
          if (widget.isForReset) {
            context.go(RouteNames.resetPasswordRoute, extra: {
              'email': widget.email,
              'code': _codeController.text.trim(),
            });
          } else {
            context.go(RouteNames.formRoute);
          }
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
              title: l10n.verify_account_title,
              subtitle: l10n.verify_account_subtitle,
            ),
            _EmailChip(email: widget.email),
            const SizedBox(height: ProjectSizes.spaceBtwItems),
            _OtpField(
              controller: _codeController,
              validator: _validateCode,
              label: l10n.verify_account_code_label,
            ),
            const SizedBox(height: ProjectSizes.spaceBtwSections),
            BlocBuilder<ButtonStateCubit, ButtonState>(
              builder: (context, state) {
                final isLoading = state is ButtonLoadingState;
                return Button3D(
                  text: l10n.verify_account_button,
                  isLoading: isLoading,
                  loadingText: l10n.verify_account_loading,
                  onPressed: () {
                    if (!(_formKey.currentState?.validate() ?? false)) {
                      return;
                    }
                    FocusScope.of(context).unfocus();
                    context.read<ButtonStateCubit>().execute(
                          usecase: sl<VerifyAccountUseCase>(),
                          params: VerifyAccountReqParam(
                            email: widget.email,
                            code: _codeController.text.trim(),
                          ),
                        );
                  },
                );
              },
            ),
            const SizedBox(height: ProjectSizes.spaceBtwItems),
            TextButton(
              onPressed: _isResending ? null : _resendCode,
              child: Text(
                _isResending
                    ? l10n.verify_account_resend_loading
                    : l10n.verify_account_resend,
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

class _EmailChip extends StatelessWidget {
  final String email;

  const _EmailChip({required this.email});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ProjectSizes.paddingMd,
        vertical: ProjectSizes.paddingSm,
      ),
      decoration: BoxDecoration(
        color: ProjectColors.orange.withOpacity(0.08),
        borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusLg),
        border: Border.all(
          color: ProjectColors.orange.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhosphorIcon(
            PhosphorIconsRegular.envelope,
            size: ProjectSizes.iconSm,
            color: ProjectColors.orange,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.verify_account_sent_to,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  email,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;

  const _OtpField({
    required this.controller,
    required this.validator,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ShadowedTextField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const PhosphorIcon(PhosphorIconsRegular.keyhole),
        counterText: '',
      ),
    );
  }
}
