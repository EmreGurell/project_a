import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:project_a/common/bloc/auth/auth_state.dart';
import 'package:project_a/utils/local_storage/storage_service.dart';

import '../../../data/models/auth/signin_req_params.dart';
import '../../../data/models/auth/signup_req_params.dart';
import '../../../domain/usecases/auth/logout.dart';
import '../../../domain/usecases/auth/signin.dart';
import '../../../domain/usecases/auth/signup.dart';

class AuthStateCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final LogoutUseCase logoutUseCase;
  final LocalStorageService localStorageService;

  AuthStateCubit({
    required this.signInUseCase,
    required this.logoutUseCase,
    required this.signUpUseCase,
    required this.localStorageService,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final result = await signInUseCase(
        param: SignInReqParam(email: email, password: password),
      );

      await result.fold(
        (failureCode) async => emit(AuthFailure(message: failureCode.toString())),
        (entity) async {
          final formDone = await localStorageService.isUserFormCompleted();
          if (formDone) {
            emit(AuthSuccess(token: entity.token));
          } else {
            emit(AuthSuccessNeedsForm());
          }
        },
      );
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    emit(AuthLoading());

    try {
      final result = await signUpUseCase.call(
        param: SignUpReqParam(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
        ),
      );

      result.fold(
        (failureCode) => emit(AuthFailure(message: failureCode.toString())),
        (userId) => emit(AuthRegistered(userId: userId, email: email)),
      );
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      final result = await logoutUseCase.call();

      await result.fold(
        (failure) async => emit(AuthFailure(message: failure.toString())),
        (_) async {
          await HydratedBloc.storage.clear(); // Tüm cache'i temizle
          emit(UnAuthenticated());
        },
      );
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
