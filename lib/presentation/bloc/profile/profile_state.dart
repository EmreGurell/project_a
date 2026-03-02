import '../../../domain/entities/user/user_entity.dart';
import '../../../domain/entities/user/user_metrics_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;
  final UserMetricsEntity? metrics;

  ProfileLoaded({required this.user, this.metrics});
}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure({required this.message});
}

