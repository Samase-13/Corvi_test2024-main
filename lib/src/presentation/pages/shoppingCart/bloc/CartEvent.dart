import 'package:corvi_app/src/domain/models/Repuestos.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddProductToCart extends CartEvent {
  final Repuesto producto;
  final int cantidad;

  const AddProductToCart(this.producto, this.cantidad);

  @override
  List<Object?> get props => [producto, cantidad];
}

class RemoveProductFromCart extends CartEvent {
  final Repuesto producto;

  const RemoveProductFromCart(this.producto);

  @override
  List<Object?> get props => [producto];
}

class UpdateProductQuantity extends CartEvent {
  final Repuesto producto;
  final int cantidad;

  const UpdateProductQuantity(this.producto, this.cantidad);

  @override
  List<Object?> get props => [producto, cantidad];
}

class LoadCart extends CartEvent {}