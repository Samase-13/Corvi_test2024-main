import 'package:corvi_app/src/domain/models/Repuestos.dart';
import 'package:equatable/equatable.dart';

abstract class DescriptionPartsState extends Equatable {
  const DescriptionPartsState();

  @override
  List<Object?> get props => [];
}

class DescriptionPartsInitial extends DescriptionPartsState {}

class DescriptionPartsLoading extends DescriptionPartsState {}

class DescriptionPartsLoaded extends DescriptionPartsState {
  final Repuesto repuesto;
  final int quantity; // Cantidad seleccionada

  const DescriptionPartsLoaded(this.repuesto, {this.quantity = 0});

  DescriptionPartsLoaded copyWith({int? quantity}) {
    return DescriptionPartsLoaded(
      repuesto,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [repuesto, quantity];
}

class DescriptionPartsError extends DescriptionPartsState {
  final String error;

  const DescriptionPartsError(this.error);

  @override
  List<Object?> get props => [error];
}
