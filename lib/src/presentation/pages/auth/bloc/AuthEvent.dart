// AuthEvent.dart
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String correo;
  final String password;

  LoginEvent(this.correo, this.password);
}

class RegisterEvent extends AuthEvent {
  final String nombres;
  final String apellido;
  final String numeroTelefonico;
  final String correo;
  final String password;

  RegisterEvent({
    required this.nombres,
    required this.apellido,
    required this.numeroTelefonico,
    required this.correo,
    required this.password,
  });
}

class LogoutEvent extends AuthEvent {}

class CheckAuthStatusEvent extends AuthEvent {}
