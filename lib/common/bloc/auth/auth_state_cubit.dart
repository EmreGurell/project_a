import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/common/bloc/auth/auth_state.dart';

import '../../../data/models/auth/signin_req_params.dart';
import '../../../data/models/auth/signup_req_params.dart';
import '../../../domain/usecases/auth/logout.dart';
import '../../../domain/usecases/auth/signin.dart';
import '../../../domain/usecases/auth/signup.dart';

class AuthStateCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final LogoutUseCase logoutUseCase;

  AuthStateCubit( {required this.signInUseCase,required this.logoutUseCase, required this.signUpUseCase})
    : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final result = await signInUseCase(
        param: SignInReqParam(email: email, password: password),
      );

      result.fold(
        (failureCode) => emit(AuthFailure(message: failureCode.toString())),
        (token) => emit(AuthSuccess(token: token.toString())),
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
      (_) => emit(AuthRegistered()),
    );
  }

  Future<void> logout() async {
    // Çıkış işlemi başlarken loading emit edebilirsin (opsiyonel)
    emit(AuthLoading());

    try {
      // Local storage'dan token silme işlemini UseCase üzerinden yapıyoruz
      final result = await logoutUseCase.call();

      result.fold(
            (failure) => emit(AuthFailure(message: failure.toString())),
            (_) => emit(UnAuthenticated()), // State'i UnAuthenticated yapıyoruz
      );
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
