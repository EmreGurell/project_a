abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
}

class Authenticated extends AuthState {}

class UnAuthenticated extends AuthState {}

class AuthRegistered extends AuthState {}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}