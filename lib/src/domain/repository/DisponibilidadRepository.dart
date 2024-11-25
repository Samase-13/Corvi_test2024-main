// DisponibilidadRepository.dart
import 'package:corvi_app/src/domain/utils/Resource.dart';
import 'package:corvi_app/src/domain/models/Disponibilidad.dart';

abstract class DisponibilidadRepository {
  Future<Resource<void>> guardarDisponibilidad(Disponibilidad disponibilidad);
}
