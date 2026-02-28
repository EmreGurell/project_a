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
import 'package:project_a/shared/widgets/buttons/3d_button.dart';
import 'package:project_a/shared/widgets/snackbar/custom_snackbar.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/image_paths.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/device/device_utility.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/presentation/widgets/auth/shadowed_text_field.dart';

import '../../../data/models/auth/signup_req_params.dart';
import '../../../domain/usecases/auth/signup.dart';
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
        child: Stack(
          children: const [
            _RegisterBackground(),
            _RegisterCard(),
            _RegisterMascot(),
          ],
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
        child: SingleChildScrollView(
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
  final _formKey = GlobalKey<FormState>();
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
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ButtonStateCubit, ButtonState>(
      listener: (context, state) {
        if (state is ButtonSuccessState) {
          context.go(
            RouteNames.verifyAccountRoute,
            extra: {
              'email': emailController.text.trim(),
              'isForReset': false,
            },
          );
        }
        if (state is ButtonFailureState) {
          final mappedMessage = ErrorMapper.getErrorMessage(
            context,
            state.errorMessage,
          );
          AppSnackbar.showError(context, message: mappedMessage);
        }
      },
      child: Form(
        key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormTitles(
            title: l10n.register_title,
            subtitle: l10n.register_subtitle,
          ),
          const SizedBox(height: ProjectSizes.spaceBtwItems),

          Row(
            children: [
              Expanded(
                child: ShadowedTextField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) => FormValidators.firstName(value, l10n),
                  decoration: InputDecoration(
                    labelText: l10n.register_first_name_label,
                    prefixIcon: const PhosphorIcon(PhosphorIconsRegular.user),
                  ),
                ),
              ),
              const SizedBox(width: ProjectSizes.spaceBtwItems),
              Expanded(
                child: ShadowedTextField(
                  controller: surnameController,
                  keyboardType: TextInputType.name,
                  validator: (value) => FormValidators.lastName(value, l10n),
                  decoration: InputDecoration(
                    labelText: l10n.register_last_name_label,
                    prefixIcon: const PhosphorIcon(PhosphorIconsRegular.user),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: ProjectSizes.spaceBtwItems),

          ShadowedTextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => FormValidators.email(value, l10n),
            decoration: InputDecoration(
              labelText: l10n.email,
              hintText: l10n.email,
              prefixIcon: const PhosphorIcon(PhosphorIconsRegular.envelope),
            ),
          ),

          const SizedBox(height: ProjectSizes.spaceBtwItems),

          ShadowedTextField(
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (value) => FormValidators.password(value, l10n),
            decoration: InputDecoration(
              labelText: l10n.password,
              hintText: l10n.password,
              prefixIcon: const PhosphorIcon(PhosphorIconsRegular.lock),
              suffixIcon: IconButton(
                icon: const PhosphorIcon(PhosphorIconsRegular.eye),
                onPressed: () {},
              ),
            ),
          ),

          const SizedBox(height: ProjectSizes.spaceBtwItems),

          Button3D(
            text: l10n.register_button,
            onPressed: () async {
              if (!(_formKey.currentState?.validate() ?? false)) {
                return;
              }
              FocusScope.of(context).unfocus();
              context.read<ButtonStateCubit>().execute(
                usecase: sl<SignUpUseCase>(),
                params: SignUpReqParam(
                  firstName: nameController.text.trim(),
                  lastName: surnameController.text.trim(),
                  email: emailController.text.trim(),
                  password: passwordController.text,
                ),
              );
            },
          ),

          const SizedBox(height: ProjectSizes.spaceBtwItems),

          TextButton(
            onPressed: () => context.go(RouteNames.loginRoute),
            child: Text(
              l10n.register_have_account,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),

          const SocialLogin(),
        ],
      ),
    ),
    );
  }
}
