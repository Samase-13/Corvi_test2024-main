import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:corvi_app/src/data/api/ApiConfig.dart';

class TokenService {
  final String _baseUrl = ApiConfig.API; // Usa la URL configurada en ApiConfig

  // Método para generar el token
  Future<bool> generateToken(int usuarioId) async {
    final response = await http.post(
      Uri.parse("http://$_baseUrl/tokens/generate"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'usuario_id': usuarioId}),
    );

    if (response.statusCode == 200) {
      return true; // Token generado correctamente
    } else {
      throw Exception('Error al generar el token: ${response.body}');
    }
  }

  // Método para validar el token
  Future<bool> validateToken(int usuarioId, String token) async {
    final response = await http.post(
      Uri.parse("http://$_baseUrl/tokens/validate"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'usuario_id': usuarioId, 'token': token}),
    );

    if (response.statusCode == 200) {
      return true; // Token válido
    } else {
      throw Exception('Error al validar el token: ${response.body}');
    }
  }
}
