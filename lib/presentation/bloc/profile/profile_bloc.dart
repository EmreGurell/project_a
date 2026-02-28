
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/presentation/bloc/profile/profile_event.dart';
import 'package:project_a/presentation/bloc/profile/profile_state.dart';

import '../../../domain/usecases/user/get_current_user.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;


  ProfileBloc({required this.getCurrentUserUseCase}) : super(ProfileInitial()) {
    on<FetchProfileEvent>(_onFetchProfile);
    // on<LogoutEvent>(_onLogout); // Örnek ekleme
  }

  Future<void> _onFetchProfile(FetchProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    final result = await getCurrentUserUseCase.call();

    result.fold(
          (failure) => emit(ProfileFailure(message: failure.toString())),
          (userEntity) => emit(ProfileLoaded(user: userEntity)),
    );
  }
}