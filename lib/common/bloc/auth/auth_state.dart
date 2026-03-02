abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String token;
  AuthSuccess({required this.token});
}

/// Login başarılı ama form henüz tamamlanmamış → /form'a yönlendir
class AuthSuccessNeedsForm extends AuthState {}

class Authenticated extends AuthState {}

class UnAuthenticated extends AuthState {}

class AuthRegistered extends AuthState {
  final String userId;
  final String email;
  AuthRegistered({required this.userId, required this.email});
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}
