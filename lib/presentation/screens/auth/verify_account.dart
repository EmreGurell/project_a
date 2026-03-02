import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/core/errors/error_mapper.dart';
import 'package:project_a/core/router/route_names.dart';
import 'package:project_a/data/models/auth/resend_verification_req_params.dart';
import 'package:project_a/data/models/auth/verify_account_req_params.dart';
import 'package:project_a/domain/usecases/auth/resend_verification_code.dart';
import 'package:project_a/domain/usecases/auth/verify_account.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/presentation/widgets/auth/form_titles.dart';
import 'package:project_a/shared/widgets/snackbar/custom_snackbar.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/image_paths.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/device/device_utility.dart';

class VerifyAccountPage extends StatelessWidget {
  final String email;

  /// Register akışı için userId (isForReset=false). Şifre sıfırlama akışında null.
  final String? userId;

  /// true  → şifre sıfırlama akışından gelindi (kodu gir → reset password)
  /// false → kayıt sonrası hesap doğrulama (kodu gir → form)
  final bool isForReset;

  const VerifyAccountPage({
    super.key,
    required this.email,
    this.userId,
    this.isForReset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const _VerifyBg(),
          const _VerifyMascot(),
          _VerifyCard(email: email, userId: userId, isForReset: isForReset),
        ],
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
  final String? userId;
  final bool isForReset;

  const _VerifyCard({
    required this.email,
    required this.userId,
    required this.isForReset,
  });

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
              color: Colors.black.withValues(alpha: 0.06),
              offset: const Offset(0, -4),
              blurRadius: 12,
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          child: _VerifyAccountForm(
            email: email,
            userId: userId,
            isForReset: isForReset,
          ),
        ),
      ),
    );
  }
}

class _VerifyAccountForm extends StatefulWidget {
  final String email;
  final String? userId;
  final bool isForReset;

  const _VerifyAccountForm({
    required this.email,
    required this.userId,
    required this.isForReset,
  });

  @override
  State<_VerifyAccountForm> createState() => _VerifyAccountFormState();
}

class _VerifyAccountFormState extends State<_VerifyAccountForm> {
  final _pinController = PinInputController();
  bool _isLoading = false;
  bool _isResending = false;

  AppLocalizations get l10n => AppLocalizations.of(context)!;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _onCodeCompleted(String code) async {
    if (widget.isForReset) {
      context.go(RouteNames.resetPasswordRoute, extra: {
        'email': widget.email,
        'code': code,
      });
      return;
    }

    setState(() => _isLoading = true);
    try {
      final result = await sl<VerifyAccountUseCase>().call(
        param: VerifyAccountReqParam(userId: widget.userId!, code: code),
      );
      result.fold(
        (error) {
          if (mounted) {
            _pinController.clear();
            AppSnackbar.showError(
              context,
              message: ErrorMapper.getErrorMessage(context, error),
            );
          }
        },
        (_) {
          if (mounted) context.go(RouteNames.formRoute);
        },
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _resendCode() async {
    if (widget.userId == null) return;
    setState(() => _isResending = true);
    try {
      final result = await sl<ResendVerificationCodeUseCase>().call(
        param: ResendVerificationReqParam(userId: widget.userId!),
      );
      result.fold(
        (error) {
          if (mounted) {
            AppSnackbar.showError(
              context,
              message: ErrorMapper.getErrorMessage(context, error),
            );
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormTitles(
          title: l10n.verify_account_title,
          subtitle: l10n.verify_account_subtitle,
        ),
        _EmailChip(email: widget.email),
        const SizedBox(height: ProjectSizes.spaceBtwSections),
        MaterialPinField(
          length: 6,
          keyboardType: TextInputType.number,
          pinController: _pinController,
          autoFocus: true,
          onCompleted: _isLoading ? null : _onCodeCompleted,
          onChanged: (_) {},
          theme: const MaterialPinTheme(
            shape: MaterialPinShape.outlined,
            cellSize: Size(48, 56),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            focusedBorderColor: ProjectColors.orange,
            filledBorderColor: ProjectColors.orange,
            fillColor: Colors.white,
            focusedFillColor: Colors.white,
            filledFillColor: Colors.white,
            entryAnimation: MaterialPinAnimation.fade,
          ),
        ),
        if (_isLoading) ...[
          const SizedBox(height: ProjectSizes.spaceBtwItems),
          const Center(
            child: CircularProgressIndicator(color: ProjectColors.orange),
          ),
        ],
        if (!widget.isForReset) ...[
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
      ],
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
        color: ProjectColors.orange.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusLg),
        border: Border.all(
          color: ProjectColors.orange.withValues(alpha: 0.3),
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
