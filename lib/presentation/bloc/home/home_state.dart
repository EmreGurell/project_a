import '../../../domain/entities/nutrition/nutrition_entity.dart';
import '../../../domain/entities/user/user_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final UserEntity user;
  final NutritionEntity nutrition;
  final List<DateTime> dateRange;
  final DateTime selectedDate;

  HomeLoaded({
    required this.user,
    required this.nutrition,
    required this.dateRange,
    required this.selectedDate,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}