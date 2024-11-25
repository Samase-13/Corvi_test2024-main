import 'package:corvi_app/src/data/dataSource/remote/services/RepuestosService.dart';
import 'package:corvi_app/src/domain/models/Repuestos.dart';
import 'package:corvi_app/src/domain/repository/RepuestosRepository.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';

class RepuestosRepositoryImpl implements RepuestosRepository {
  final RepuestosService repuestosService;

  RepuestosRepositoryImpl(this.repuestosService);

  // Implementación del método para obtener la lista de repuestos
  @override
  Future<Resource<List<Repuesto>>> fetchRepuestos() {
    return repuestosService.fetchRepuestos();  // Llama al método de AuthServices que hace la solicitud GET
  }

  // Implementación del método para obtener los detalles de un repuesto específico
  @override
  Future<Resource<Repuesto>> fetchRepuestoDetail(int partId) {
    return repuestosService.fetchRepuestoDetail(partId); // Llama al método de AuthServices para obtener el detalle del repuesto
  }
}
