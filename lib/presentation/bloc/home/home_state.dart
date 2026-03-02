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

  HomeLoaded({
    required this.user,
    required this.dateRange,
    required this.selectedDate,
    this.nutrition,
    this.isNutritionLoading = false,
  });

  HomeLoaded copyWith({
    UserEntity? user,
    NutritionEntity? nutrition,
    bool clearNutrition = false,
    DateTime? selectedDate,
    List<DateTime>? dateRange,
    bool? isNutritionLoading,
  }) {
    return HomeLoaded(
      user: user ?? this.user,
      dateRange: dateRange ?? this.dateRange,
      selectedDate: selectedDate ?? this.selectedDate,
      nutrition: clearNutrition ? null : (nutrition ?? this.nutrition),
      isNutritionLoading: isNutritionLoading ?? this.isNutritionLoading,
    );
  }
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}