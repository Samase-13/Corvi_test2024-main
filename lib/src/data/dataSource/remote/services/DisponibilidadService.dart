import 'package:corvi_app/src/data/api/ApiConfig.dart';
import 'package:corvi_app/src/domain/models/Disponibilidad.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DisponibilidadService {
  // Método para realizar la petición POST de /disponibilidad/alquilar
  Future<Resource<void>> guardarDisponibilidad(Disponibilidad disponibilidad) async {
    try {
      // Construimos la URL para la ruta /disponibilidad/alquilar
      Uri url = Uri.http(ApiConfig.API, '/disponibilidad/alquilar');

      // Configuramos los encabezados para la solicitud
      Map<String, String> headers = {"Content-Type": "application/json"};

      // Realizamos la petición POST con el cuerpo en formato JSON
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(disponibilidad.toJson()),
      );

      // Verificamos si la respuesta fue exitosa
      if (response.statusCode == 201) {
        // Devolvemos un estado de éxito
        return Success(null);
      } else {
        // En caso de error en la respuesta, devolvemos un estado de Error
        return Error('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      // Capturamos cualquier excepción y devolvemos un estado de Error
      print('Error $e');
      return Error('Error al registrar la disponibilidad: $e');
    }
  }
}
