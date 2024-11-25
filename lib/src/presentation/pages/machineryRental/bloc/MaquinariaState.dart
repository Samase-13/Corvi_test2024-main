import 'package:corvi_app/src/domain/models/Maquinarias.dart';
import 'package:equatable/equatable.dart';

abstract class MaquinariaState extends Equatable {
  const MaquinariaState();

  @override
  List<Object?> get props => [];
}

class MaquinariaInitial extends MaquinariaState {}

class MaquinariaLoading extends MaquinariaState {}

class MaquinariaLoaded extends MaquinariaState {
  final List<Maquinaria> maquinaria;

  const MaquinariaLoaded(this.maquinaria);

  @override
  List<Object?> get props => [maquinaria];
}

class MaquinariaError extends MaquinariaState {
  final String error;

  const MaquinariaError(this.error);

  @override
  List<Object?> get props => [error];
}
