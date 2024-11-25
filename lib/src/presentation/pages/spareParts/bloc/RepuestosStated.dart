import 'package:corvi_app/src/domain/models/Repuestos.dart';
import 'package:equatable/equatable.dart';

abstract class RepuestosState extends Equatable {
  const RepuestosState();

  @override
  List<Object?> get props => [];
}

class RepuestosLoading extends RepuestosState {}

class RepuestosLoaded extends RepuestosState {
  final List<Repuesto> repuestos;

  const RepuestosLoaded(this.repuestos);

  @override
  List<Object?> get props => [repuestos];
}

class RepuestosError extends RepuestosState {
  final String error;

  const RepuestosError(this.error);

  @override
  List<Object?> get props => [error];
}
