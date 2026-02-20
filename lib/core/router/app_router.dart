import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_a/core/router/route_names.dart';
import 'package:project_a/presentation/screens/auth/login.dart';
import 'package:project_a/presentation/screens/onboarding/onboarding.dart';
import 'package:project_a/splash.dart';

import '../../common/bloc/button/button_state_cubit.dart';
import '../di/service_locator.dart';

final router = GoRouter(initialLocation: RouteNames.initialRoute,
routes: [
  GoRoute(path: RouteNames.initialRoute,builder: (context,state)=>  SplashPage()),
  GoRoute(
    path: '/onboarding',
    builder: (context, state) => BlocProvider(
      create: (_) => sl<ButtonStateCubit>(),
      child: OnboardingPage(),
    ),
  ),
  GoRoute(path: RouteNames.loginRoute,pageBuilder: (context, state) {
return CustomTransitionPage(
key: state.pageKey,
child: const LoginPage(),
transitionDuration: const Duration(milliseconds: 500), // Animasyon süresi
transitionsBuilder: (context, animation, secondaryAnimation, child) {
// Burada FadeTransition, SlideTransition veya ScaleTransition kullanabilirsin
return FadeTransition(
opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
child: child,
);
},);
})]);