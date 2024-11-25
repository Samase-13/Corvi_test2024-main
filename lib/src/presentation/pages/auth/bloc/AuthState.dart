abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess(this.message);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

// Modificación aquí para incluir userName y userApellido en AuthAuthenticated
class AuthAuthenticated extends AuthState {
  final String? userName;
  final String? userApellido;

  AuthAuthenticated({this.userName, this.userApellido});
}

class AuthUnauthenticated extends AuthState {}
