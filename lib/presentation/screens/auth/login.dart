import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/shared/widgets/snackbar/custom_snackbar.dart';
import 'package:project_a/shared/widgets/buttons/3d_button.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/image_paths.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/constants/texts.dart';
import 'package:project_a/utils/device/device_utility.dart';
import 'package:project_a/presentation/widgets/auth/shadowed_text_field.dart';

import '../../../common/bloc/auth/auth_state.dart';
import '../../../common/bloc/auth/auth_state_cubit.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/router/route_names.dart';
import '../../../core/validation/form_validators.dart';
import '../../widgets/auth/form_titles.dart';
import '../../widgets/auth/social_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthStateCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go(RouteNames.homeRoute);
          }
          if (state is AuthFailure) {
            final mappedMessage = ErrorMapper.getErrorMessage(
              context,
              state.message,
            );
            AppSnackbar.showError(context, message: mappedMessage);
          }
        },
        child: Stack(
          children: const [_LoginBackground(), _LoginCard(), _LoginMascot()],
        ),
      ),
    );
  }
}

class _LoginBackground extends StatelessWidget {
  const _LoginBackground();

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

class _LoginMascot extends StatelessWidget {
  const _LoginMascot();

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

class _LoginCard extends StatelessWidget {
  const _LoginCard();

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
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          child: const _LoginForm(),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscure = true;

  AppLocalizations get l10n => AppLocalizations.of(context)!;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormTitles(title: l10n.welcome, subtitle: l10n.good_to_see_you),
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildPasswordField(),
          _buildForgotPasswordButton(),
          const SizedBox(height: 8),
          _buildLoginButton(),
          const SizedBox(height: 8),
          _buildSignUpButton(),
          const SocialLogin(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return ShadowedTextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => FormValidators.email(value, l10n),
      decoration: InputDecoration(
        labelText: l10n.email,
        prefixIcon: PhosphorIcon(PhosphorIconsRegular.envelope),
      ),
    );
  }

  Widget _buildPasswordField() {
    return ShadowedTextField(
      controller: _passwordController,
      obscureText: _isPasswordObscure,
      validator: (value) => FormValidators.password(value, l10n),
      decoration: InputDecoration(
        labelText: l10n.password,
        prefixIcon: const PhosphorIcon(PhosphorIconsRegular.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordObscure ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _isPasswordObscure = !_isPasswordObscure;
            });
          },
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          l10n.forgot_password,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<AuthStateCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Button3D(
          text: l10n.sign_in,
          isLoading: isLoading,
          loadingText: l10n.sign_in_loading,
          onPressed: () {
            if (!(_formKey.currentState?.validate() ?? false)) {
              return;
            }
            FocusScope.of(context).unfocus();

            context.read<AuthStateCubit>().login(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
          },
        );
      },
    );
  }

  Widget _buildSignUpButton() {
    return TextButton(
      onPressed: () => context.go(RouteNames.registerRoute),
      child: Text(
        l10n.dont_have_account,
        style: Theme.of(
          context,
        ).textTheme.labelLarge!.copyWith(decoration: TextDecoration.underline),
      ),
    );
  }
}
