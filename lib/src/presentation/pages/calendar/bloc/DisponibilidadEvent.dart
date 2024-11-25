import 'package:equatable/equatable.dart';
import 'package:corvi_app/src/domain/models/Disponibilidad.dart';

abstract class DisponibilidadEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GuardarDisponibilidadEvent extends DisponibilidadEvent {
  final Disponibilidad disponibilidad;

  GuardarDisponibilidadEvent(this.disponibilidad);

  @override
  List<Object?> get props => [disponibilidad];
}
