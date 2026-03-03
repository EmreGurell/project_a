import 'dart:developer' as dev;

import 'package:project_a/utils/local_storage/storage_service.dart';

import '../../domain/entities/app_entry_status.dart';
import '../../domain/repositories/app_entry_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user/user_repository.dart';

class AppEntryRepositoryImpl implements AppEntryRepository {
  final AuthRepository authRepository;
  final LocalStorageService localService;
  final UserRepository userRepository;

  AppEntryRepositoryImpl({
    required this.authRepository,
    required this.localService,
    required this.userRepository,
  });

  @override
  Future<AppEntryStatus> checkAppEntry() async {
    final isFirstTime = await localService.isOnboardingSeen();
    if (!isFirstTime) return AppEntryStatus.onboarding;

    final isAuthenticated = await authRepository.isAuthenticated();
    if (!isAuthenticated) return AppEntryStatus.unauthenticated;

    // Local flag önce kontrol et — daha önce tamamlandıysa API'ye gitme
    final localDone = await localService.isUserFormCompleted();
    dev.log('[AppEntry] localDone=$localDone');
    if (localDone) return AppEntryStatus.authenticated;

    // API'den profil varlığını kontrol et
    try {
      final userResult = await userRepository.getCurrentUser();
      return await userResult.fold(
        (err) async {
          dev.log('[AppEntry] getCurrentUser Left: $err');
          return AppEntryStatus.profileSetup;
        },
        (user) async {
          dev.log('[AppEntry] hasProfile=${user.hasProfile}');
          if (user.hasProfile) {
            await localService.setUserFormCompleted();
            return AppEntryStatus.authenticated;
          }
          return AppEntryStatus.profileSetup;
        },
      );
    } catch (e) {
      dev.log('[AppEntry] exception: $e');
      return AppEntryStatus.profileSetup;
    }
  }

  @override
  Future<void> setOnboardingSeen() async {
    await localService.setOnboardingSeen();
  }
}
