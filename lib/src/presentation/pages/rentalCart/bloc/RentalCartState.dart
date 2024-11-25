import 'package:equatable/equatable.dart';

abstract class RentalCartState extends Equatable {
  const RentalCartState();

  @override
  List<Object?> get props => [];
}

class RentalCartInitial extends RentalCartState {}

class RentalCartLoaded extends RentalCartState {
  final String img;
  final String nombre;
  final String tipo;
  final double precio;
  final String precioTipo;

  const RentalCartLoaded(this.img, this.nombre, this.tipo, this.precio, this.precioTipo);

  @override
  List<Object?> get props => [img, nombre, tipo, precio, precioTipo];
}
class RentalCartTotalCalculated extends RentalCartState {
  final double total;

  const RentalCartTotalCalculated(this.total);

  @override
  List<Object?> get props => [total];
}

