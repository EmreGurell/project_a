import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_a/core/router/route_names.dart';

import 'common/bloc/app_entry/app_entry_state.dart';
import 'common/bloc/app_entry/app_entry_state_cubit.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<AppEntryCubit>().checkAppStatus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppEntryCubit, AppEntryState>(
      listener: (context, state) {
        if (state is AppEntryOnboarding) {
          context.go(RouteNames.onboardingRoute);
        }

        if (state is AppEntryUnAuthenticated) {
          context.go(RouteNames.loginRoute);
        }

        if (state is AppEntryAuthenticated) {
          context.go(RouteNames.homeRoute);
        }
      },
      child: Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
