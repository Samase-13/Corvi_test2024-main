import 'package:corvi_app/src/domain/models/Maquinarias.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';

abstract class MaquinariaRepository {
  // Método para obtener la lista de maquinaria
  Future<Resource<List<Maquinaria>>> fetchMaquinaria();

  // Método para obtener los detalles de una maquinaria específica
  Future<Resource<Maquinaria>> fetchMaquinariaDetail(int maquinariaId); // <-- Nuevo método agregado
}
