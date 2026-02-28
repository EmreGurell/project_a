import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_a/core/router/route_names.dart';

import '../../common/bloc/auth/auth_state_cubit.dart';
import '../../common/bloc/button/button_state_cubit.dart';
import '../../presentation/bloc/home/home_bloc.dart';
import '../../presentation/bloc/home/home_event.dart';
import '../../presentation/bloc/profile/profile_bloc.dart';
import '../../presentation/bloc/profile/profile_event.dart';
import '../../presentation/navigation/main_scaffold.dart';
import '../../presentation/bloc/form/profile_setup_bloc.dart';
import '../../presentation/bloc/form/profile_setup_event.dart';
import '../../presentation/screens/auth/forgot_password.dart';
import '../../presentation/screens/auth/login.dart';
import '../../presentation/screens/auth/register.dart';
import '../../presentation/screens/auth/reset_password.dart';
import '../../presentation/screens/auth/verify_account.dart';
import '../../presentation/screens/form/form.dart';
import '../../presentation/screens/home/home.dart';
import '../../presentation/screens/onboarding/onboarding.dart';
import '../../presentation/screens/profile/profile.dart';
import '../../splash.dart';
import '../di/service_locator.dart';

final router = GoRouter(
  initialLocation: RouteNames.initialRoute,
  routes: [
    GoRoute(
      path: RouteNames.initialRoute,
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: RouteNames.registerRoute,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: RouteNames.onboardingRoute,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<ButtonStateCubit>(),
        child: const OnboardingPage(),
      ),
    ),
    GoRoute(
      path: RouteNames.loginRoute,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<AuthStateCubit>(),
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: RouteNames.formRoute,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<ProfileSetupBloc>()..add(LoadFormProgress()),
        child: const FormPage(),
      ),
    ),
    GoRoute(
      path: RouteNames.forgotPasswordRoute,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: RouteNames.verifyAccountRoute,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return VerifyAccountPage(
          email: extra['email'] as String,
          isForReset: extra['isForReset'] as bool? ?? false,
        );
      },
    ),
    GoRoute(
      path: RouteNames.resetPasswordRoute,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return ResetPasswordPage(
          email: extra['email'] as String,
          code: extra['code'] as String,
        );
      },
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        // 1. Sekme: Anasayfa
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.homeRoute,
              builder: (context, state) => BlocProvider(
                create: (_) => sl<HomeBloc>()..add(LoadCurrentUser()),
                child: const HomePage(),
              ),
            ),
          ],
        ),

        // 2. Sekme: Tarifler
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/recipes', // RouteNames'e eklemeyi unutma
              builder: (context, state) => const Center(child: Text('Tarifler Yakında!')),
            ),
          ],
        ),

        // 3. Sekme: Topluluk
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/community', // Buraya da bi isim verirsin sonra
              builder: (context, state) => const Center(child: Text('Topluluk Akışı')),
            ),
          ],
        ),

        // 4. Sekme: Profil
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.profileRoute,
              builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => sl<ProfileBloc>()..add(FetchProfileEvent()),
                  ),
                  BlocProvider.value(value: sl<AuthStateCubit>()),
                ],
                child: const ProfilePage(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);