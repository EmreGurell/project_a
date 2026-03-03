import '../../../domain/entities/nutrition/nutrition_entity.dart';
import '../../../domain/entities/user/user_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final UserEntity user;
  final NutritionEntity? nutrition;
  final List<DateTime> dateRange;
  final DateTime selectedDate;
  final bool isNutritionLoading;
  final int waterGlasses;

  HomeLoaded({
    required this.user,
    required this.dateRange,
    required this.selectedDate,
    this.nutrition,
    this.isNutritionLoading = false,
    this.waterGlasses = 0,
  });

  HomeLoaded copyWith({
    UserEntity? user,
    NutritionEntity? nutrition,
    bool clearNutrition = false,
    DateTime? selectedDate,
    List<DateTime>? dateRange,
    bool? isNutritionLoading,
    int? waterGlasses,
  }) {
    return HomeLoaded(
      user: user ?? this.user,
      dateRange: dateRange ?? this.dateRange,
      selectedDate: selectedDate ?? this.selectedDate,
      nutrition: clearNutrition ? null : (nutrition ?? this.nutrition),
      isNutritionLoading: isNutritionLoading ?? this.isNutritionLoading,
      waterGlasses: waterGlasses ?? this.waterGlasses,
    );
  }
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}