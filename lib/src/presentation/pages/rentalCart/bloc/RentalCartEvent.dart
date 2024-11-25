import 'package:equatable/equatable.dart';

abstract class RentalCartEvent extends Equatable {
  const RentalCartEvent();

  @override
  List<Object?> get props => [];
}

class SetRentalDetails extends RentalCartEvent {
  final String img;
  final String nombre;
  final String tipo;
  final double precio;
  final String precioTipo;

  const SetRentalDetails(this.img, this.nombre, this.tipo, this.precio, this.precioTipo);

  @override
  List<Object?> get props => [img, nombre, tipo, precio, precioTipo];
}

class CalculateTotal extends RentalCartEvent {
  final int quantity;
  final double pricePerUnit;

  const CalculateTotal(this.quantity, this.pricePerUnit);

  @override
  List<Object?> get props => [quantity, pricePerUnit];
}
