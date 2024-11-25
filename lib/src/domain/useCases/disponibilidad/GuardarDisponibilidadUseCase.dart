// GuardarDisponibilidadUseCase.dart
import 'package:corvi_app/src/domain/models/Disponibilidad.dart';
import 'package:corvi_app/src/domain/repository/DisponibilidadRepository.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';

class GuardarDisponibilidadUseCase {
  final DisponibilidadRepository disponibilidadRepository;

  GuardarDisponibilidadUseCase(this.disponibilidadRepository);

  Future<Resource<void>> call(Disponibilidad disponibilidad) async {
    return await disponibilidadRepository.guardarDisponibilidad(disponibilidad);
  }
}
