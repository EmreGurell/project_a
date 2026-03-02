import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/domain/usecases/user/get_user_metrics.dart';
import 'package:project_a/presentation/bloc/profile/profile_event.dart';
import 'package:project_a/presentation/bloc/profile/profile_state.dart';

import '../../../domain/usecases/user/get_current_user.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetUserMetricsUseCase getUserMetricsUseCase;

  ProfileBloc({
    required this.getCurrentUserUseCase,
    required this.getUserMetricsUseCase,
  }) : super(ProfileInitial()) {
    on<FetchProfileEvent>(_onFetchProfile);
  }

  Future<void> _onFetchProfile(
    FetchProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    // Both calls go to /me endpoint; run sequentially to avoid double request
    final userResult = await getCurrentUserUseCase.call();

    await userResult.fold(
      (failure) async => emit(ProfileFailure(message: failure)),
      (user) async {
        final metricsResult = await getUserMetricsUseCase.call();
        final metrics = metricsResult.fold((_) => null, (m) => m);
        emit(ProfileLoaded(user: user, metrics: metrics));
      },
    );
  }
}
