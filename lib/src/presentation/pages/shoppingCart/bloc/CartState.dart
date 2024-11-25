import 'package:corvi_app/src/domain/models/Repuestos.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Repuesto> productos;
  final Map<int, int> cantidades; // Mapa para almacenar las cantidades de cada producto

  const CartLoaded({this.productos = const [], this.cantidades = const {}});

  CartLoaded copyWith({List<Repuesto>? productos, Map<int, int>? cantidades}) {
    return CartLoaded(
      productos: productos ?? this.productos,
      cantidades: cantidades ?? this.cantidades,
    );
  }

  @override
  List<Object?> get props => [productos, cantidades];
}

class CartError extends CartState {
  final String mensaje;

  const CartError(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}
