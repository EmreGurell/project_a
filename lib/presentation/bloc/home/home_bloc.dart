import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:project_a/domain/entities/user/user_entity.dart';
import 'package:project_a/domain/usecases/home/get_data_by_date.dart';
import '../../../domain/usecases/user/get_current_user.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends HydratedBloc<HomeEvent, HomeState> {
  final GetCurrentUserUseCase getCurrentUser;
  final GetNutritionDataByDate getNutritionDataByDate;

  HomeBloc(this.getCurrentUser, this.getNutritionDataByDate)
      : super(HomeInitial()) {
    on<LoadCurrentUser>(_onLoadCurrentUser);
    on<ChangeDate>(_onChangeDate);
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

    if (cached is HomeLoaded) {
      // Cache var → anlık göster, nutrition'ı yükle
      emit(cached.copyWith(
        selectedDate: now,
        dateRange: dateRange,
        clearNutrition: true,
        isNutritionLoading: true,
      ));

      // Nutrition her zaman taze çekilir (gün içinde değişir)
      final nutritionResult = await getNutritionDataByDate(param: now);
      nutritionResult.fold(
        (_) => emit(cached.copyWith(
          selectedDate: now,
          dateRange: dateRange,
          clearNutrition: true,
          isNutritionLoading: false,
        )),
        (nutrition) => emit(cached.copyWith(
          selectedDate: now,
          dateRange: dateRange,
          nutrition: nutrition,
          isNutritionLoading: false,
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

    emit(current.copyWith(
      selectedDate: event.date,
      clearNutrition: true,
      isNutritionLoading: true,
    ));

    final result = await getNutritionDataByDate(param: event.date);
    result.fold(
      (_) => emit(current.copyWith(
        selectedDate: event.date,
        clearNutrition: true,
        isNutritionLoading: false,
      )),
      (nutrition) => emit(current.copyWith(
        selectedDate: event.date,
        nutrition: nutrition,
        isNutritionLoading: false,
      )),
    );
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
