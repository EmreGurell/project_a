abstract class HomeEvent {}

class LoadCurrentUser extends HomeEvent {}

class ChangeDate extends HomeEvent {
  final DateTime date;
  ChangeDate(this.date);
}

class IncrementWater extends HomeEvent {}

class DecrementWater extends HomeEvent {}