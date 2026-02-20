import 'package:project_a/utils/local_storage/storage_service.dart';

import '../../domain/entities/app_entry_status.dart';
import '../../domain/repositories/app_entry_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../source/auth/auth_local_service.dart';

class AppEntryRepositoryImpl implements AppEntryRepository {

  final AuthRepository authRepository;
  final LocalStorageService localService;

  AppEntryRepositoryImpl({
    required this.authRepository,
    required this.localService,
  });

  @override
  Future<AppEntryStatus> checkAppEntry() async {

    // onboarding kontrolü
    final isFirstTime = await localService.isOnboardingSeen();

    if (!isFirstTime) {
      return AppEntryStatus.onboarding;
    }

    // login kontrolü
    final isAuthenticated = await authRepository.isAuthenticated();

    if (isAuthenticated) {
      return AppEntryStatus.authenticated;
    }

    return AppEntryStatus.unauthenticated;
  }
}