import 'package:get_it/get_it.dart';
import 'package:project_a/common/bloc/auth/auth_state_cubit.dart';
import 'package:project_a/common/bloc/button/button_state_cubit.dart';
import 'package:project_a/core/network/dio_client.dart';
import 'package:project_a/data/repository/app_entry_repository_impl.dart';
import 'package:project_a/data/repository/auth_repository_impl.dart';
import 'package:project_a/data/source/auth/auth_api_service.dart';
import 'package:project_a/domain/repositories/app_entry_repository.dart';
import 'package:project_a/domain/repositories/auth_repository.dart';
import 'package:project_a/domain/usecases/auth/is_authenticated.dart';
import 'package:project_a/domain/usecases/auth/signin.dart';
import 'package:project_a/domain/usecases/auth/signup.dart';
import 'package:project_a/domain/usecases/onboarding/complete_onboarding.dart';
import 'package:project_a/utils/local_storage/storage_service.dart';

import '../../common/bloc/app_entry/app_entry_state_cubit.dart';
import '../../data/source/auth/auth_local_service.dart';
import '../../domain/usecases/check_app_entry.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {

  /// External
  sl.registerLazySingleton<DioClient>(
        () => DioClient(),
  );

  ///Storage
  sl.registerLazySingleton<LocalStorageService>(
        () => LocalStorageServiceImpl(),
  );
  /// Services
  sl.registerLazySingleton<AuthApiService>(
        () => AuthApiServiceImpl(),
  );

  sl.registerLazySingleton<AuthLocalService>(
        () => AuthLocalServiceImpl(storageService: sl()),
  );

  /// Repositories
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      apiService: sl(),
      localService: sl(),
    ),
  );

  sl.registerLazySingleton<AppEntryRepository>(
        () => AppEntryRepositoryImpl(
      authRepository: sl(),
      localService: sl(),
    ),
  );

  /// UseCases
  sl.registerLazySingleton(() => SignUpUseCase(authRepository: sl()));
  sl.registerLazySingleton(()=>SignInUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => IsAuthenticatedUseCase(authRepository: sl()));
  sl.registerLazySingleton<CheckAppEntry>(() => CheckAppEntry(sl()));
  sl.registerLazySingleton<CompleteOnboardingUseCase>(()=> CompleteOnboardingUseCase(repository: sl()));
  /// Cubit
  sl.registerFactory<AppEntryCubit>(() => AppEntryCubit(sl(),sl()));
  sl.registerFactory<ButtonStateCubit>(()=>ButtonStateCubit());
  sl.registerFactory<AuthStateCubit>(()=>AuthStateCubit(signInUseCase: sl(), signUpUseCase: sl()));
}