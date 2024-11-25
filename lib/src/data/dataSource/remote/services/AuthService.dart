import 'package:corvi_app/src/data/api/ApiConfig.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../domain/models/User.dart';

class AuthService {
  // Método para iniciar sesión en la ruta /usuarios/login
  Future<Resource<Usuario>> login(String correo, String password) async {
    try {
      Uri url = Uri.http(ApiConfig.API, '/usuarios/login');
      Map<String, String> headers = {"Content-Type": "application/json"};
      String body = json.encode({
        'correo': correo,
        'contraseña': password,
      });

      print("Cuerpo de la solicitud: $body");  // Añadir un print aquí para ver el cuerpo que se envía

      final response = await http.post(url, headers: headers, body: body);

      print('Respuesta del servidor: ${response.body}'); // Imprime la respuesta completa del servidor

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Usuario usuario = Usuario.fromJson(data['usuario']);  // Asegúrate de que 'usuario' esté en el cuerpo de la respuesta
        return Success(usuario);
      } else {
        return Error('Error en el inicio de sesión: ${response.body}');
      }
    } catch (e) {
      return Error('Error de conexión: $e');
    }
  }


  // Método para registrar un usuario en la ruta /usuarios
  Future<Resource<Usuario>> register(Usuario usuario) async {
    try {
      Uri url = Uri.http(ApiConfig.API, '/usuarios/');
      Map<String, String> headers = {"Content-Type": "application/json"};

      // Asegúrate de que el body esté enviando todos los campos necesarios
      String body = json.encode({
        'nombres': usuario.nombres,
        'apellido': usuario.apellido,
        'numero_telefonico': usuario.numeroTelefonico,
        'correo': usuario.correo,
        'contraseña': usuario.password,
      });

      final response = await http.post(url, headers: headers, body: body);

      print(
          'Respuesta del servidor: ${response.body}'); // Imprime la respuesta completa del servidor

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        Usuario usuarioRegistrado = Usuario.fromJson(data);
        return Success(usuarioRegistrado);
      } else {
        return Error(
            'Error en el registro: ${response.body}'); // Devuelve la respuesta completa en el error
      }
    } catch (e) {
      return Error('Error de conexión: $e');
    }
  }
}
