import 'package:equatable/equatable.dart';

abstract class DisponibilidadState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DisponibilidadInitial extends DisponibilidadState {}

class DisponibilidadLoading extends DisponibilidadState {}

class DisponibilidadSuccess extends DisponibilidadState {}

class DisponibilidadError extends DisponibilidadState {
  final String message;

  DisponibilidadError(this.message);

  @override
  List<Object?> get props => [message];
}
