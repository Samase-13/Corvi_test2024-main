import 'dart:convert';
import 'package:corvi_app/src/data/api/ApiConfig.dart';
import 'package:corvi_app/src/domain/models/RucData.dart';
import 'package:http/http.dart' as http;
// Aquí seguimos usando ApiConfig para la URL base

class RucService {
  final String _token = 'apis-token-10713.PAAkKb3ZBpvqWHrYW1JtyNDeS1pfW36Y';

  Future<RucData> fetchRucData(String ruc) async {
    // Ajustamos la URL para que sea compatible con tu formato habitual
    Uri url = Uri.http(ApiConfig.API, '/ruc/extendida/$ruc');

    // Realizamos la petición GET con el token en los headers
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return RucData.fromJson(data); // Convertimos el JSON en un objeto RucData
    } else {
      throw Exception('Error al obtener los datos del RUC: ${response.statusCode}');
    }
  }
}