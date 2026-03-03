import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:project_a/domain/entities/user/user_entity.dart';
import 'package:project_a/domain/usecases/home/get_data_by_date.dart';
import 'package:project_a/utils/local_storage/storage_service.dart';
import '../../../domain/usecases/user/get_current_user.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends HydratedBloc<HomeEvent, HomeState> {
  final GetCurrentUserUseCase getCurrentUser;
  final GetNutritionDataByDate getNutritionDataByDate;
  final LocalStorageService localStorageService;

  HomeBloc(this.getCurrentUser, this.getNutritionDataByDate, this.localStorageService)
      : super(HomeInitial()) {
    on<LoadCurrentUser>(_onLoadCurrentUser);
    on<ChangeDate>(_onChangeDate);
    on<IncrementWater>(_onIncrementWater);
    on<DecrementWater>(_onDecrementWater);
  }

  Future<void> _onLoadCurrentUser(
    LoadCurrentUser event,
    Emitter<HomeState> emit,
  ) async {
    final now = DateTime.now();
    final dateRange = List.generate(
      14,
      (i) => now.subtract(Duration(days: 13 - i)),
    );

    final cached = state;
    final water = await localStorageService.getWaterGlasses(now);

    if (cached is HomeLoaded) {
      // Cache var → anlık göster, nutrition'ı yükle
      emit(cached.copyWith(
        selectedDate: now,
        dateRange: dateRange,
        clearNutrition: true,
        isNutritionLoading: true,
        waterGlasses: water,
      ));

      // Nutrition her zaman taze çekilir (gün içinde değişir)
      final nutritionResult = await getNutritionDataByDate(param: now);
      nutritionResult.fold(
        (_) => emit(cached.copyWith(
          selectedDate: now,
          dateRange: dateRange,
          clearNutrition: true,
          isNutritionLoading: false,
          waterGlasses: water,
        )),
        (nutrition) => emit(cached.copyWith(
          selectedDate: now,
          dateRange: dateRange,
          nutrition: nutrition,
          isNutritionLoading: false,
          waterGlasses: water,
        )),
      );

      // User sessizce arka planda güncellenir (başarısız olursa cache kalır)
      final userResult = await getCurrentUser();
      userResult.fold(
        (_) {}, // hata → cache'deki user yeterli
        (freshUser) {
          if (state is HomeLoaded) {
            emit((state as HomeLoaded).copyWith(user: freshUser));
          }
        },
      );
    } else {
      // Cache yok → tam loading akışı
      emit(HomeLoading());

      final userResult = await getCurrentUser();
      await userResult.fold(
        (error) async => emit(HomeError(error)),
        (user) async {
          final loaded = HomeLoaded(
            user: user,
            dateRange: dateRange,
            selectedDate: now,
            isNutritionLoading: true,
            waterGlasses: water,
          );
          emit(loaded);

          final nutritionResult = await getNutritionDataByDate(param: now);
          nutritionResult.fold(
            (_) => emit(loaded.copyWith(isNutritionLoading: false)),
            (nutrition) => emit(loaded.copyWith(
              nutrition: nutrition,
              isNutritionLoading: false,
            )),
          );
        },
      );
    }
  }

  Future<void> _onChangeDate(
    ChangeDate event,
    Emitter<HomeState> emit,
  ) async {
    final current = state;
    if (current is! HomeLoaded) return;

    final water = await localStorageService.getWaterGlasses(event.date);

    emit(current.copyWith(
      selectedDate: event.date,
      clearNutrition: true,
      isNutritionLoading: true,
      waterGlasses: water,
    ));

    final result = await getNutritionDataByDate(param: event.date);
    result.fold(
      (_) => emit(current.copyWith(
        selectedDate: event.date,
        clearNutrition: true,
        isNutritionLoading: false,
        waterGlasses: water,
      )),
      (nutrition) => emit(current.copyWith(
        selectedDate: event.date,
        nutrition: nutrition,
        isNutritionLoading: false,
        waterGlasses: water,
      )),
    );
  }

  Future<void> _onIncrementWater(
    IncrementWater event,
    Emitter<HomeState> emit,
  ) async {
    final current = state;
    if (current is! HomeLoaded) return;
    final newCount = current.waterGlasses + 1;
    await localStorageService.saveWaterGlasses(newCount, current.selectedDate);
    emit(current.copyWith(waterGlasses: newCount));
  }

  Future<void> _onDecrementWater(
    DecrementWater event,
    Emitter<HomeState> emit,
  ) async {
    final current = state;
    if (current is! HomeLoaded) return;
    if (current.waterGlasses == 0) return;
    final newCount = current.waterGlasses - 1;
    await localStorageService.saveWaterGlasses(newCount, current.selectedDate);
    emit(current.copyWith(waterGlasses: newCount));
  }

  // ── HydratedBloc: sadece UserEntity cache'lenir ──────────────────────────

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    try {
      final user = UserEntity(
        id: json['id'] as String,
        username: json['username'] as String? ?? '',
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        role: json['role'] as String? ?? '',
        status: json['status'] as String? ?? '',
        profilePicture: json['profilePicture'] as String?,
        hasProfile: json['hasProfile'] as bool? ?? true,
        isVerified: json['isVerified'] as bool? ?? false,
      );
      final now = DateTime.now();
      return HomeLoaded(
        user: user,
        dateRange: List.generate(14, (i) => now.subtract(Duration(days: 13 - i))),
        selectedDate: now,
        isNutritionLoading: false,
        nutrition: null, // nutrition her zaman taze çekilir
      );
    } catch (_) {
      return null; // bozuk cache → tam loading akışı
    }
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    if (state is HomeLoaded) {
      return {
        'id': state.user.id,
        'username': state.user.username,
        'email': state.user.email,
        'firstName': state.user.firstName,
        'lastName': state.user.lastName,
        'role': state.user.role,
        'status': state.user.status,
        'profilePicture': state.user.profilePicture,
        'hasProfile': state.user.hasProfile,
        'isVerified': state.user.isVerified,
      };
    }
    return null; // HomeLoading/HomeError/HomeInitial → cache'leme
  }
}
