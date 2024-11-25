import 'package:corvi_app/src/domain/models/Maquinarias.dart';
import 'package:corvi_app/src/domain/repository/MaquinariaRepository.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';

// Caso de uso específico para obtener la lista de maquinaria
class GetMaquinariaUseCase {
  final MaquinariaRepository repository;

  GetMaquinariaUseCase(this.repository);

  Future<Resource<List<Maquinaria>>> run() {
    return repository.fetchMaquinaria(); // Esto devuelve la lista de maquinaria
  }
}
