import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:project_a/shared/widgets/buttons/3d_button.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/image_paths.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/constants/texts.dart';
import 'package:project_a/utils/device/device_utility.dart';
import 'package:project_a/presentation/widgets/auth/shadowed_text_field.dart';

import '../../../common/bloc/auth/auth_state.dart';
import '../../../common/bloc/auth/auth_state_cubit.dart';
import '../../../core/router/route_names.dart';
import '../../widgets/auth/form_titles.dart';
import '../../widgets/auth/social_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = DeviceUtility.getScreenHeight(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          _buildBackground(screenHeight),
          _buildFormContainer(screenHeight),
          _buildMascot(screenHeight),
        ],
      ),
    );
  }

  Widget _buildBackground(double screenHeight) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      height: screenHeight * 0.38,
      child: Image.asset(
        ImageAndAnimationPaths.authBg,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildMascot(double screenHeight) {
    return Positioned(
      left: 0,
      right: 0,
      top: 20,
      height: screenHeight * 0.38,
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
        child: Image.asset(
          ImageAndAnimationPaths.loginMascot,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildFormContainer(double screenHeight) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FormTitles(),
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
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return ShadowedTextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: ProjectTexts.loginEmailLabel,
        hintText: ProjectTexts.loginEmailHint,
        prefixIcon: PhosphorIcon(PhosphorIconsRegular.envelope),
      ),
    );
  }

  Widget _buildPasswordField() {
    return ShadowedTextField(
      controller: _passwordController,
      obscureText: _isPasswordObscure,
      decoration: InputDecoration(
        labelText: ProjectTexts.loginPasswordLabel,
        hintText: ProjectTexts.loginPasswordHint,
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
          ProjectTexts.loginForgotPassword,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return BlocConsumer<AuthStateCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go(RouteNames.homeRoute);
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Button3D(
          text: "Giriş Yap",
          isLoading: isLoading,
          loadingText: "Giriş Yapılıyor...",
          onPressed: () {
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
        ProjectTexts.loginSignUp,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(decoration: TextDecoration.underline),
      ),
    );
  }
}