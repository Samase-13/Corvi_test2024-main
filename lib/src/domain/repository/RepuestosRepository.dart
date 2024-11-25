import 'package:corvi_app/src/domain/models/Repuestos.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';

abstract class RepuestosRepository {
  // Método para obtener la lista de repuestos
  Future<Resource<List<Repuesto>>> fetchRepuestos();

  // Método para obtener los detalles de un repuesto específico
  Future<Resource<Repuesto>> fetchRepuestoDetail(int partId); // <-- Nuevo método agregado
}
