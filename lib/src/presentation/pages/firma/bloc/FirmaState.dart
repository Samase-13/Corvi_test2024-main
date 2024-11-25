import 'package:equatable/equatable.dart';

abstract class FirmaState extends Equatable {
  const FirmaState();

  @override
  List<Object?> get props => [];
}

class FirmaInitial extends FirmaState {}

class FirmaLoading extends FirmaState {}

class FirmaCodigoEnviado extends FirmaState {}

class FirmaEsperandoCodigo extends FirmaState {}

class FirmaCodigoValidado extends FirmaState {}

class FirmaError extends FirmaState {
  final String message;

  const FirmaError(this.message);

  @override
  List<Object?> get props => [message];
}
