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

    // API'den profil varlığını kontrol et
    final userResult = await userRepository.getCurrentUser();
    return await userResult.fold(
      (_) async {
        // Network hatası: local flag'e fall back
        final done = await localService.isUserFormCompleted();
        return done ? AppEntryStatus.authenticated : AppEntryStatus.profileSetup;
      },
      (user) async =>
          user.hasProfile ? AppEntryStatus.authenticated : AppEntryStatus.profileSetup,
    );
  }

  @override
  Future<void> setOnboardingSeen() async {
    await localService.setOnboardingSeen();
  }
}
