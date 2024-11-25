import 'package:corvi_app/src/domain/repository/RepuestosRepository.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';
import 'package:corvi_app/src/domain/models/Repuestos.dart';

class GetRepuestosUseCase {
  final RepuestosRepository repository;

  GetRepuestosUseCase(this.repository);

  Future<Resource<List<Repuesto>>> run() {
    return repository.fetchRepuestos(); // Esto devuelve la lista de repuestos
  }
}
