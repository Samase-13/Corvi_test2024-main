import 'package:corvi_app/src/data/api/ApiConfig.dart';
import 'package:corvi_app/src/domain/models/Repuestos.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RepuestosService {
  // Método para realizar la petición GET de /repuestos
  Future<Resource<List<Repuesto>>> fetchRepuestos() async {
    try {
      // Construimos la URL para la ruta /repuestos
      Uri url = Uri.http(ApiConfig.API, '/repuestos');

      // Realizamos la petición GET con encabezados, si es necesario
      Map<String, String> headers = {"Content-Type": "application/json"};
      final response = await http.get(url, headers: headers);

      // Verificamos si la respuesta fue exitosa
      if (response.statusCode == 200) {
        // Decodificamos la respuesta JSON y la convertimos en una lista de objetos Repuesto
        List<Repuesto> repuestos = repuestosFromJson(response.body);

        // Devolvemos los repuestos en un estado de éxito
        return Success(repuestos);
      } else {
        // En caso de error en la respuesta, devolvemos un estado de Error
        return Error('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      // Capturamos cualquier excepción y devolvemos un estado de Error
      print('Error $e');
      return Error('Error al obtener repuestos: $e');
    }
  }

  // Método para realizar la petición GET de /repuestos/{id} para obtener detalles específicos de un repuesto
  Future<Resource<Repuesto>> fetchRepuestoDetail(int partId) async {
    try {
      // Construimos la URL para la ruta /repuestos/{id}
      Uri url = Uri.http(ApiConfig.API, '/repuestos/$partId');

      // Realizamos la petición GET con encabezados, si es necesario
      Map<String, String> headers = {"Content-Type": "application/json"};
      final response = await http.get(url, headers: headers);

      // Verificamos si la respuesta fue exitosa
      if (response.statusCode == 200) {
        // Decodificamos la respuesta JSON y la convertimos en un objeto Repuesto
        Repuesto repuesto = Repuesto.fromJson(json.decode(response.body));

        // Devolvemos el repuesto en un estado de éxito
        return Success(repuesto);
      } else {
        // En caso de error en la respuesta, devolvemos un estado de Error
        return Error('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      // Capturamos cualquier excepción y devolvemos un estado de Error
      print('Error $e');
      return Error('Error al obtener detalles del repuesto: $e');
    }
  }
}
