import 'package:dartz/dartz.dart'; // Right/Left için gerekli
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/domain/entities/nutrition/nutrition_entity.dart';
import 'package:project_a/domain/usecases/home/get_data_by_date.dart';
import '../../../domain/usecases/user/get_current_user.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentUserUseCase getCurrentUser;
  final GetNutritionDataByDate getNutritionDataByDate;

  HomeBloc(this.getCurrentUser, this.getNutritionDataByDate) : super(HomeInitial()) {
    on<LoadCurrentUser>(_onLoadCurrentUser);
  }

  Future<void> _onLoadCurrentUser(
      LoadCurrentUser event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoading());
    final now = DateTime.now();
    final List<DateTime> dateRange = List.generate(
      14,
          (index) => now.subtract(Duration(days: 13 - index)),
    );

    // =========================================================================
    // GERÇEK API ÇAĞRISI (Endpoint hazır olduğunda burayı aç)
    /*
    final results = await Future.wait([
      getCurrentUser(),
      getNutritionDataByDate(param: now),
    ]);
    */
    // =========================================================================

    // =========================================================================

    final results = await Future.wait([
      getCurrentUser(),
      Future.value(Right<String, NutritionEntity>(
        NutritionEntity(
          id: 0,
          totalCalories: 1450,
          protein: 85,
          carbs: 120,
          fat: 45,
          date: now,
        ),
      )),
    ]);
    // =========================================================================

    final userResult = results[0];
    final nutritionResult = results[1];

    userResult.fold(
          (userError) => emit(HomeError(userError)),
          (user) {
        // nutritionResult'ı dinamik casting yerine tip güvenli şekilde fold ediyoruz
        nutritionResult.fold(
              (nutritionError) => emit(HomeError(nutritionError)),
              (nutritionData) {
            // nutritionData burada otomatik olarak NutritionEntity tipindedir
            emit(HomeLoaded(
              user: user,
              nutrition: nutritionData as NutritionEntity,
              dateRange: dateRange,
              selectedDate: now,
            ));
          },
        );
      },
    );
  }
}