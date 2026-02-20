import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_a/common/bloc/button/button_state.dart';
import 'package:project_a/common/bloc/button/button_state_cubit.dart';
import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/core/router/route_names.dart';
import 'package:project_a/shared/widgets/buttons/3d_button.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/image_paths.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/constants/texts.dart';
import 'package:project_a/utils/device/device_utility.dart';
import 'package:project_a/presentation/widgets/auth/shadowed_text_field.dart';

import '../../../data/models/auth/signup_req_params.dart';
import '../../../domain/usecases/signup.dart';
import '../../widgets/auth/form_titles.dart';
import '../../widgets/auth/social_login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => sl<ButtonStateCubit>(),
        child: BlocListener<ButtonStateCubit,ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState){
              context.go(RouteNames.homeRoute);
            }
             if (state is ButtonFailureState){
              var snackBar = SnackBar(content: Text(state.errorMessage));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Stack(
            children: const [
              _RegisterBackground(),
              _RegisterCard(),
              _RegisterMascot(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterBackground extends StatelessWidget {
  const _RegisterBackground();

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

class _RegisterMascot extends StatelessWidget {
  const _RegisterMascot();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 20,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Image.asset(
          ImageAndAnimationPaths.registerMascot,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _RegisterCard extends StatelessWidget {
  const _RegisterCard();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: DeviceUtility.getScreenHeight(context) * 0.31 - 80,
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
        child:  SingleChildScrollView(
          padding: EdgeInsets.all(ProjectSizes.pagePadding),
          child: _RegisterForm(),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController nameController;
  late final TextEditingController surnameController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    surnameController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const FormTitles(),
        const SizedBox(height: ProjectSizes.spaceBtwItems),

        Row(
          children: [
            Expanded(
              child: ShadowedTextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: ProjectTexts.registerFirstNameLabel,
                  hintText: ProjectTexts.registerFirstNameHint,
                  prefixIcon:
                      const PhosphorIcon(PhosphorIconsRegular.user),
                ),
              ),
            ),
            const SizedBox(width: ProjectSizes.spaceBtwItems),
            Expanded(
              child: ShadowedTextField(
                controller: surnameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: ProjectTexts.registerLastNameLabel,
                  hintText: ProjectTexts.registerLastNameHint,
                  prefixIcon:
                      const PhosphorIcon(PhosphorIconsRegular.user),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: ProjectSizes.spaceBtwItems),

        ShadowedTextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: ProjectTexts.loginEmailLabel,
            hintText: ProjectTexts.loginEmailHint,
            prefixIcon:
                const PhosphorIcon(PhosphorIconsRegular.envelope),
          ),
        ),

        const SizedBox(height: ProjectSizes.spaceBtwItems),

        ShadowedTextField(
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
            labelText: ProjectTexts.loginPasswordLabel,
            hintText: ProjectTexts.loginPasswordHint,
            prefixIcon:
                const PhosphorIcon(PhosphorIconsRegular.lock),
            suffixIcon: IconButton(
              icon: const PhosphorIcon(
                PhosphorIconsRegular.eye,
              ),
              onPressed: () {},
            ),
          ),
        ),

        const SizedBox(height: ProjectSizes.spaceBtwItems),

        Button3D(
          text: ProjectTexts.registerButton,
          onPressed: () async {
            context.read<ButtonStateCubit>().execute(usecase: sl<SignUpUseCase>(),
              params: SignUpReqParam(
                name: nameController.text.trim(),
                surname: surnameController.text.trim(),
                email: emailController.text.trim(),
                password: passwordController.text,
              ),
            );
            
          },
        ),

        const SizedBox(height: ProjectSizes.spaceBtwItems),

        TextButton(
          onPressed: () {},
          child: Text(
            ProjectTexts.registerHaveAccount,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(
                  decoration: TextDecoration.underline,
                ),
          ),
        ),

        const SocialLogin(),
      ],
    );
  }
}

