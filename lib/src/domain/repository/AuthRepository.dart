import '../models/User.dart';
import '../utils/Resource.dart';

abstract class AuthRepository {
  Future<Usuario?> getUserSession();
  Future<bool> logout();
  Future<void> saveUserSession(Usuario usuario);
  Future<Resource<Usuario>> login(String correo, String password);
  Future<Resource<Usuario>> register(Usuario usuario);
}
