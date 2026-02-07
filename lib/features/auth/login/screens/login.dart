import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_a/common/widgets/buttons/3d_button.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/image_paths.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/constants/texts.dart';
import 'package:project_a/utils/device/device_utility.dart';
import 'package:project_a/utils/widgets/shadowed_text_field.dart';
import 'package:project_a/features/auth/login/widgets/index.dart';

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: DeviceUtility.getScreenHeight(context) * 0.38,
            child: Image.asset(
              ImageAndAnimationPaths.loginBg,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            top: DeviceUtility.getScreenHeight(context) * 0.38 - 27,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: ProjectColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: ProjectSizes.pagePadding,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(ProjectSizes.pagePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const FormTitles(),
                      ShadowedTextField(
                        controller: TextEditingController(),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: ProjectTexts.loginEmailLabel,
                          hintText: ProjectTexts.loginEmailHint,
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return ProjectTexts.loginEmailEmpty;
                          if (!v.contains('@'))
                            return ProjectTexts.loginEmailInvalid;
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ShadowedTextField(
                        controller: TextEditingController(),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: ProjectTexts.loginPasswordLabel,
                          hintText: ProjectTexts.loginPasswordHint,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              true ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return ProjectTexts.loginPasswordEmpty;
                          if (v.length < 6)
                            return ProjectTexts.loginPasswordShort;
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            ProjectTexts.loginForgotPassword,
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Button3D(
                        text: ProjectTexts.loginButton,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 8),

                      TextButton(
                        onPressed: () {},
                        child: Text(
                          ProjectTexts.loginSignUp,
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                      const SocialLogin(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            top: 20,
            height: MediaQuery.of(context).size.height * 0.38,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
                left: 24.0,
                right: 24.0,
              ),
              child: Image.asset(
                ImageAndAnimationPaths.loginMascot,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
