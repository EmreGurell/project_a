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
    NutritionEntity? nutrition,
    DateTime? selectedDate,
    bool? isNutritionLoading,
  }) {
    return HomeLoaded(
      user: user,
      dateRange: dateRange,
      selectedDate: selectedDate ?? this.selectedDate,
      nutrition: nutrition ?? this.nutrition,
      isNutritionLoading: isNutritionLoading ?? this.isNutritionLoading,
    );
  }
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}