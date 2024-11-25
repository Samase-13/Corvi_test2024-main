import 'package:corvi_app/src/data/api/ApiConfig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FirmaService {
  final String _baseUrl = ApiConfig.API; // Usamos la URL tal como está en ApiConfig

  /// Método para enviar el código
  Future<bool> enviarCodigo(int usuarioId) async {
    try {
      final url = _asegurarHttp("$_baseUrl/tokens/generate"); // Aseguramos el esquema HTTP
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'usuario_id': usuarioId}),
      );

      if (response.statusCode == 200) {
        return true; // Código enviado exitosamente
      } else {
        throw Exception('Error al enviar el código: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  /// Método para validar el código
  Future<bool> validarCodigo(int usuarioId, String codigo) async {
    try {
      final url = _asegurarHttp("$_baseUrl/tokens/validate"); // Aseguramos el esquema HTTP
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'usuario_id': usuarioId, 'token': codigo}),
      );

      if (response.statusCode == 200) {
        return true; // Token válido
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        final responseData = jsonDecode(response.body);
        throw Exception(responseData['message'] ?? 'Código inválido');
      } else {
        throw Exception('Error al validar el código: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  /// Método privado para asegurar que la URL tenga el esquema HTTP
  String _asegurarHttp(String url) {
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      return "http://$url"; // Agrega http:// si no existe
    }
    return url;
  }
}
