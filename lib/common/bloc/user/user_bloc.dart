import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/domain/entities/user_entity.dart';
import 'package:project_a/domain/usecases/auth/get_me.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetMeUseCase getMeUseCase;

  UserBloc({required this.getMeUseCase}) : super(UserInitial()) {
    on<GetUserMeEvent>(_onGetMe);
  }

  Future<void> _onGetMe(GetUserMeEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final result = await getMeUseCase.call();

      result.fold(
        (failureCode) => emit(UserFailure(message: failureCode.toString())),
        (userEntity) => emit(UserLoaded(user: userEntity)),
      );
    } catch (e) {
      emit(UserFailure(message: e.toString()));
    }
  }
}
