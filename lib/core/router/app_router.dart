import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_a/core/router/route_names.dart';

import '../../common/bloc/auth/auth_state_cubit.dart';
import '../../common/bloc/button/button_state_cubit.dart';
import '../../presentation/screens/auth/login.dart';
import '../../presentation/screens/auth/register.dart';
import '../../presentation/screens/home/home.dart';
import '../../presentation/screens/onboarding/onboarding.dart';
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
      builder: (context, state) => RegisterPage(),
    ),

    GoRoute(
      path: RouteNames.onboardingRoute,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<ButtonStateCubit>(),
        child: OnboardingPage(),
      ),
    ),

    GoRoute(
      path: RouteNames.homeRoute,
      builder: (context, state) => HomePage(),
    ),


    GoRoute(
      path: RouteNames.loginRoute,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 500),
          child: BlocProvider(
            create: (_) => sl<AuthStateCubit>(),
            child: const LoginPage(),
          ),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
              CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);