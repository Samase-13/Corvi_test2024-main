import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/User.dart';
import '../../domain/repository/AuthRepository.dart';
import '../../domain/utils/Resource.dart';
import '../dataSource/remote/services/AuthService.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<Resource<Usuario>> login(String correo, String password) async {
    final result = await _authService.login(correo, password);
    if (result is Success<Usuario>) {
      await saveUserSession(result.data!); // Guardamos la sesión del usuario
      return Success(result.data!);
    } else if (result is Error<Usuario>) {
      final errorMessage = (result as Error<Usuario>).message; // Accede a la propiedad `message` de `Error`
      return Error<Usuario>(errorMessage);
    }
    return Error<Usuario>('Error desconocido');
  }

  @override
  Future<Resource<Usuario>> register(Usuario usuario) async {
    final result = await _authService.register(usuario);
    if (result is Success<Usuario>) {
      await saveUserSession(result.data!); // Guardamos la sesión del usuario al registrarse
      return Success(result.data!);
    } else if (result is Error<Usuario>) {
      final errorMessage = (result as Error<Usuario>).message; // Accede a la propiedad `message` de `Error`
      return Error<Usuario>(errorMessage);
    }
    return Error<Usuario>('Error desconocido');
  }

  @override
  Future<void> saveUserSession(Usuario usuario) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('usuario', usuario.toJson().toString());
  }

  @override
  Future<Usuario?> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('usuario');
    if (userData != null) {
      return Usuario.fromJson(jsonDecode(userData));
    }
    return null;
  }

  @override
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('usuario'); // Elimina la sesión del usuario
  }


  @override
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('usuario');
    if (userData != null) {
      try {
        final userJson = jsonDecode(userData);
        return userJson['id']; // Devuelve el campo correcto según tu modelo
      } catch (e) {
        print('Error al parsear el JSON del usuario: $e');
      }
    }
    return null; // Retorna null si no hay datos o si ocurre un error
  }
}