part of 'user_bloc.dart'; // zate user_bloc dan çekiyor gerekli importları

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserEntity user;
  UserLoaded({required this.user});
}

class UserFailure extends UserState {
  final String message;
  UserFailure({required this.message});
}
