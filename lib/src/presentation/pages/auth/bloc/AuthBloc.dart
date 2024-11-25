import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../domain/models/User.dart';
import '../../../../domain/useCases/auth/AuthUseCases.dart';
import '../../../../domain/utils/Resource.dart';
import 'AuthEvent.dart';
import 'AuthState.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCases authUseCases;

  AuthBloc(this.authUseCases) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authUseCases.login.run(event.correo, event.password);

    if (result is Success<Usuario>) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      prefs.setInt('idUsuario', result.data!.id!);
      prefs.setString('userEmail', event.correo);
      prefs.setString('userName', result.data!.nombres);
      prefs.setString('userApellido', result.data!.apellido);

      emit(AuthAuthenticated(
        userName: result.data!.nombres,
        userApellido: result.data!.apellido,
      ));
    } else if (result is Error<Usuario>) {
      emit(AuthFailure(result.message));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    Usuario newUser = Usuario(
      nombres: event.nombres,
      apellido: event.apellido,
      numeroTelefonico: event.numeroTelefonico,
      correo: event.correo,
      password: event.password,
    );
    final result = await authUseCases.register.run(newUser);

    if (result is Success<Usuario>) {
      emit(AuthSuccess("Registro exitoso"));
    } else if (result is Error<Usuario>) {
      emit(AuthFailure(result.message));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Elimina todos los datos de usuario

    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckAuthStatus(CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    print("Verificando estado de autenticación...");
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      String? userName = prefs.getString('userName');
      String? userApellido = prefs.getString('userApellido');

      if (state is! AuthAuthenticated) {
        print("Usuario autenticado: $userName $userApellido");
        emit(AuthAuthenticated(userName: userName, userApellido: userApellido));
      }
    } else {
      if (state is! AuthUnauthenticated) {
        print("Usuario no autenticado");
        emit(AuthUnauthenticated());
      }
    }
  }

}
