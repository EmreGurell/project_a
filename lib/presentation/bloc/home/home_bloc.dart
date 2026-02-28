import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/domain/usecases/home/get_data_by_date.dart';
import '../../../domain/usecases/user/get_current_user.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
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
    emit(HomeLoading());

    final now = DateTime.now();
    final dateRange = List.generate(
      14,
      (i) => now.subtract(Duration(days: 13 - i)),
    );

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

        final nutritionResult =
            await getNutritionDataByDate(param: now);
        nutritionResult.fold(
          (error) => emit(loaded.copyWith(isNutritionLoading: false)),
          (nutrition) => emit(loaded.copyWith(
            nutrition: nutrition,
            isNutritionLoading: false,
          )),
        );
      },
    );
  }

  Future<void> _onChangeDate(
    ChangeDate event,
    Emitter<HomeState> emit,
  ) async {
    final current = state;
    if (current is! HomeLoaded) return;

    emit(current.copyWith(
      selectedDate: event.date,
      isNutritionLoading: true,
    ));

    final result = await getNutritionDataByDate(param: event.date);
    result.fold(
      (error) => emit(current.copyWith(
        selectedDate: event.date,
        isNutritionLoading: false,
      )),
      (nutrition) => emit(current.copyWith(
        selectedDate: event.date,
        nutrition: nutrition,
        isNutritionLoading: false,
      )),
    );
  }
}
