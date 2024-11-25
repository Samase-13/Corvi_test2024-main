import 'package:corvi_app/src/domain/models/Maquinarias.dart';
import 'package:corvi_app/src/domain/repository/MaquinariaRepository.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';

// Caso de uso completo para gestionar la lista y los detalles de maquinaria
class MaquinariaUseCase {
  final MaquinariaRepository repository;

  MaquinariaUseCase(this.repository);

  // Método para obtener toda la maquinaria
  Future<Resource<List<Maquinaria>>> getMaquinaria() {
    return repository.fetchMaquinaria();
  }

  // Método para obtener los detalles de una maquinaria específica
  Future<Resource<Maquinaria>> getMaquinariaDetail(int maquinariaId) {
    return repository.fetchMaquinariaDetail(maquinariaId); // Asume que el método existe en el repositorio
  }
}
