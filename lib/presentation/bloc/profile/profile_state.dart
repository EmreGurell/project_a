import '../../../domain/entities/user/user_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final UserEntity user;
  ProfileLoaded({required this.user});
}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure({required this.message});
}

