import 'package:corvi_app/src/data/api/ApiConfig.dart';
import 'package:corvi_app/src/domain/models/Maquinarias.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MaquinariaService {
  // Método para realizar la petición GET de /maquinaria
  Future<Resource<List<Maquinaria>>> fetchMaquinaria() async {
    try {
      // Construimos la URL para la ruta /maquinaria
      Uri url = Uri.http(ApiConfig.API, '/maquinaria');

      // Realizamos la petición GET con encabezados, si es necesario
      Map<String, String> headers = {"Content-Type": "application/json"};
      final response = await http.get(url, headers: headers);

      // Verificamos si la respuesta fue exitosa
      if (response.statusCode == 200) {
        // Decodificamos la respuesta JSON y la convertimos en una lista de objetos Maquinaria
        List<Maquinaria> maquinaria = maquinariaFromJson(response.body);

        // Devolvemos la lista de maquinaria en un estado de éxito
        return Success(maquinaria);
      } else {
        // En caso de error en la respuesta, devolvemos un estado de Error
        return Error('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      // Capturamos cualquier excepción y devolvemos un estado de Error
      print('Error $e');
      return Error('Error al obtener maquinaria: $e');
    }
  }

  // Método para realizar la petición GET de /maquinaria/{id} para obtener detalles específicos de una maquinaria
  Future<Resource<Maquinaria>> fetchMaquinariaDetail(int maquinariaId) async {
    try {
      // Construimos la URL para la ruta /maquinaria/{id}
      Uri url = Uri.http(ApiConfig.API, '/maquinaria/$maquinariaId');

      // Realizamos la petición GET con encabezados, si es necesario
      Map<String, String> headers = {"Content-Type": "application/json"};
      final response = await http.get(url, headers: headers);

      // Verificamos si la respuesta fue exitosa
      if (response.statusCode == 200) {
        // Decodificamos la respuesta JSON y la convertimos en un objeto Maquinaria
        Maquinaria maquinaria = Maquinaria.fromJson(json.decode(response.body));

        // Devolvemos la maquinaria en un estado de éxito
        return Success(maquinaria);
      } else {
        // En caso de error en la respuesta, devolvemos un estado de Error
        return Error('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      // Capturamos cualquier excepción y devolvemos un estado de Error
      print('Error $e');
      return Error('Error al obtener detalles de la maquinaria: $e');
    }
  }
}
