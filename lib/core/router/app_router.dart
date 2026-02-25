import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_a/common/bloc/user/user_bloc.dart';
import 'package:project_a/core/router/route_names.dart';
import 'package:project_a/presentation/navigation/main_scaffold.dart';
import 'package:project_a/presentation/screens/community/community.dart';
import 'package:project_a/presentation/screens/recipes/recipes.dart';

import '../../common/bloc/auth/auth_state_cubit.dart';
import '../../common/bloc/button/button_state_cubit.dart';
import '../../presentation/screens/auth/login.dart';
import '../../presentation/screens/auth/register.dart';
import '../../presentation/screens/home/home.dart';
import '../../presentation/screens/onboarding/onboarding.dart';
import '../../presentation/screens/profile/profile.dart';
import '../../splash.dart';
import '../di/service_locator.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteNames.initialRoute,
  routes: [
    GoRoute(
      path: RouteNames.initialRoute,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => SplashPage(),
    ),

    GoRoute(
      path: RouteNames.registerRoute,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => RegisterPage(),
    ),

    GoRoute(
      path: RouteNames.onboardingRoute,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<ButtonStateCubit>(),
        child: OnboardingPage(),
      ),
    ),

    GoRoute(
      path: RouteNames.loginRoute,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 500),
          child: BlocProvider(
            create: (_) => sl<AuthStateCubit>(),
            child: const LoginPage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          },
        );
      },
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BlocProvider<UserBloc>(
          create: (_) => sl<UserBloc>()..add(GetUserMeEvent()),
          child: MainScaffold(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.homeRoute,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.recipesRoute,
              builder: (context, state) => const RecipesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.communityRoute,
              builder: (context, state) => const CommunityPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.profileRoute,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
