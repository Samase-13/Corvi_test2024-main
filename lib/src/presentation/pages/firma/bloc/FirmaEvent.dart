import 'package:equatable/equatable.dart';

abstract class FirmaEvent extends Equatable {
  const FirmaEvent();

  @override
  List<Object?> get props => [];
}

class EnviarCodigo extends FirmaEvent {}

class ValidarCodigo extends FirmaEvent {
  final String codigo;

  const ValidarCodigo(this.codigo);

  @override
  List<Object?> get props => [codigo];
}
