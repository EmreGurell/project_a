import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/common/bloc/app_entry/app_entry_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/app_entry_status.dart';
import '../../../domain/usecases/check_app_entry.dart';
import '../../../domain/usecases/onboarding/complete_onboarding.dart';

class AppEntryCubit extends Cubit<AppEntryState> {

  final CheckAppEntry checkAppEntryUseCase;
  final CompleteOnboardingUseCase completeOnboardingUseCase;

  AppEntryCubit(this.checkAppEntryUseCase, this.completeOnboardingUseCase)
      : super(AppEntryInitial());

  Future<void> checkAppStatus() async {
    emit(AppEntryInitial());

    final status = await checkAppEntryUseCase();

    switch (status) {
      case AppEntryStatus.onboarding:
        emit(AppEntryOnboarding());
        break;
      case AppEntryStatus.unauthenticated:
        emit(AppEntryUnAuthenticated());
        break;
      case AppEntryStatus.authenticated:
        emit(AppEntryAuthenticated());
        break;
      case AppEntryStatus.profileSetup:
        emit(AppEntryProfileSetup());
        break;
    }
  }
  Future<void> completeOnboarding() async {
    await completeOnboardingUseCase();
  }
}