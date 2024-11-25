// DisponibilidadRepositoryImpl.dart
import 'package:corvi_app/src/data/dataSource/remote/services/DisponibilidadService.dart';
import 'package:corvi_app/src/domain/models/Disponibilidad.dart';
import 'package:corvi_app/src/domain/repository/DisponibilidadRepository.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';

class DisponibilidadRepositoryImpl implements DisponibilidadRepository {
  final DisponibilidadService disponibilidadService;

  DisponibilidadRepositoryImpl(this.disponibilidadService);

  @override
  Future<Resource<void>> guardarDisponibilidad(Disponibilidad disponibilidad) {
    // Llama al servicio para guardar la disponibilidad
    return disponibilidadService.guardarDisponibilidad(disponibilidad);
  }
}
