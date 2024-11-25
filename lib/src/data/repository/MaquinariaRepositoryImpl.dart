
import 'package:corvi_app/src/data/dataSource/remote/services/MaquinariaService.dart';
import 'package:corvi_app/src/domain/models/Maquinarias.dart';
import 'package:corvi_app/src/domain/repository/MaquinariaRepository.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';

class MaquinariaRepositoryImpl implements MaquinariaRepository {
  final MaquinariaService maquinariaService;

  MaquinariaRepositoryImpl(this.maquinariaService);

  // Implementación del método para obtener la lista de maquinaria
  @override
  Future<Resource<List<Maquinaria>>> fetchMaquinaria() {
    return maquinariaService.fetchMaquinaria();  // Llama al método de MaquinariaService que hace la solicitud GET
  }

  // Implementación del método para obtener los detalles de una maquinaria específica
  @override
  Future<Resource<Maquinaria>> fetchMaquinariaDetail(int maquinariaId) {
    return maquinariaService.fetchMaquinariaDetail(maquinariaId); // Llama al método de MaquinariaService para obtener el detalle de la maquinaria
  }
}
