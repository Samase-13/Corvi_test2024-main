import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CartEvent.dart';
import 'CartState.dart';
import 'package:corvi_app/src/domain/models/Repuestos.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddProductToCart>(_onAddProductToCart);
    on<RemoveProductFromCart>(_onRemoveProductFromCart);
    on<UpdateProductQuantity>(_onUpdateProductQuantity);
    add(LoadCart()); // Disparar el evento para cargar el carrito al iniciar
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final productosJson = prefs.getString('cartProducts');
    final cantidadesJson = prefs.getString('cartQuantities');

    if (productosJson != null && cantidadesJson != null) {
      final List<dynamic> decodedProductos = jsonDecode(productosJson);
      final List<Repuesto> productos =
          decodedProductos.map((e) => Repuesto.fromJson(e)).toList();

      // Convertir las claves de String a int en el Map
      final Map<int, int> cantidades =
          (jsonDecode(cantidadesJson) as Map<String, dynamic>)
              .map((key, value) => MapEntry(int.parse(key), value as int));

      emit(CartLoaded(productos: productos, cantidades: cantidades));
    } else {
      emit(CartLoaded(productos: [], cantidades: {}));
    }
  }

  Future<void> _onAddProductToCart(
      AddProductToCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedProducts = List<Repuesto>.from(currentState.productos);
      final updatedQuantities = Map<int, int>.from(currentState.cantidades);

      if (updatedQuantities.containsKey(event.producto.idRepuestos)) {
        updatedQuantities[event.producto.idRepuestos] =
            updatedQuantities[event.producto.idRepuestos]! + event.cantidad;
      } else {
        updatedProducts.add(event.producto);
        updatedQuantities[event.producto.idRepuestos] = event.cantidad;
      }

      emit(currentState.copyWith(
          productos: updatedProducts, cantidades: updatedQuantities));
      _saveCartToPreferences(updatedProducts, updatedQuantities);
    } else {
      final newState = CartLoaded(
          productos: [event.producto],
          cantidades: {event.producto.idRepuestos: event.cantidad});
      emit(newState);
      _saveCartToPreferences(newState.productos, newState.cantidades);
    }
  }

  Future<void> _onRemoveProductFromCart(
      RemoveProductFromCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedProducts = List<Repuesto>.from(currentState.productos)
        ..remove(event.producto);
      final updatedQuantities = Map<int, int>.from(currentState.cantidades)
        ..remove(event.producto.idRepuestos);

      emit(currentState.copyWith(
          productos: updatedProducts, cantidades: updatedQuantities));
      _saveCartToPreferences(updatedProducts, updatedQuantities);
    }
  }

  Future<void> _onUpdateProductQuantity(
      UpdateProductQuantity event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedQuantities = Map<int, int>.from(currentState.cantidades);

      if (event.cantidad > 0) {
        updatedQuantities[event.producto.idRepuestos] = event.cantidad;
      } else {
        updatedQuantities.remove(event.producto.idRepuestos);
      }

      emit(currentState.copyWith(cantidades: updatedQuantities));
      _saveCartToPreferences(currentState.productos, updatedQuantities);
    }
  }

  Future<void> _saveCartToPreferences(
      List<Repuesto> productos, Map<int, int> cantidades) async {
    final prefs = await SharedPreferences.getInstance();
    final productosJson = jsonEncode(productos.map((e) => e.toJson()).toList());

    // Convertir las claves de Map<int, int> a Map<String, int> para que sea JSON encodable
    final cantidadesJson = jsonEncode(
        cantidades.map((key, value) => MapEntry(key.toString(), value)));

    await prefs.setString('cartProducts', productosJson);
    await prefs.setString('cartQuantities', cantidadesJson);
  }
}
