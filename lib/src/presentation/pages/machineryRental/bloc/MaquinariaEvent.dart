import 'package:equatable/equatable.dart';

abstract class MaquinariaEvent extends Equatable {
  const MaquinariaEvent();

  @override
  List<Object?> get props => [];
}

class FetchMaquinaria extends MaquinariaEvent {
  const FetchMaquinaria();
}

class FetchFilteredMaquinaria extends MaquinariaEvent {
  final String tipo;

  const FetchFilteredMaquinaria(this.tipo);

  @override
  List<Object?> get props => [tipo];
}
