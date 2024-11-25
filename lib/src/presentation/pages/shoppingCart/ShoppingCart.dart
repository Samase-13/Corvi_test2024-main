import 'dart:convert';
import 'dart:io';
import 'package:corvi_app/src/data/api/ApiConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corvi_app/src/domain/models/Repuestos.dart';
import 'package:corvi_app/src/presentation/pages/shoppingCart/bloc/CartBloc.dart';
import 'package:corvi_app/src/presentation/pages/shoppingCart/bloc/CartState.dart';
import 'package:corvi_app/src/presentation/pages/shoppingCart/bloc/CartEvent.dart';
import 'package:corvi_app/src/presentation/pages/payment/PaymentWebView.dart';

import '../auth/bloc/AuthBloc.dart';
import '../auth/bloc/AuthState.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Carrito de Compras',
          style: TextStyle(
            fontFamily: 'Oswald',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded && state.productos.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.productos.length,
                      itemBuilder: (context, index) {
                        final Repuesto producto = state.productos[index];
                        final int cantidad =
                            state.cantidades[producto.idRepuestos] ?? 1;
                        return _buildCartItem(producto, cantidad, context);
                      },
                    );
                  } else {
                    return const Center(child: Text('El carrito está vacío'));
                  }
                },
              ),
            ),
            Divider(thickness: 1, color: Colors.grey[300]),
            _buildSummarySection(context),
            const SizedBox(height: 10),
            _buildPayButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(Repuesto producto, int cantidad, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: const Color.fromARGB(255, 233, 233, 233),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              producto.imagen,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producto.nombre,
                    style: const TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${producto.voltaje} V',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7A7A7A),
                    ),
                  ),
                  Text(
                    'S/. ${producto.precio.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.amber[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    context
                        .read<CartBloc>()
                        .add(UpdateProductQuantity(producto, cantidad - 1));
                  },
                ),
                Text(
                  '$cantidad',
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    context
                        .read<CartBloc>()
                        .add(UpdateProductQuantity(producto, cantidad + 1));
                  },
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () {
                context.read<CartBloc>().add(RemoveProductFromCart(producto));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        double subtotal = 0;
        const double envio = 18.00;
        bool hasProducts = false;

        if (state is CartLoaded) {
          subtotal = state.productos.fold(0, (sum, producto) {
            final cantidad = state.cantidades[producto.idRepuestos] ?? 1;
            return sum + (producto.precio * cantidad);
          });
          hasProducts = state.productos.isNotEmpty;
        }

        final total = hasProducts ? subtotal + envio : subtotal;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _buildSummaryRow(
                  'Subtotal:', 'S/. ${subtotal.toStringAsFixed(2)}'),
              if (hasProducts)
                _buildSummaryRow('Envío:', 'S/. ${envio.toStringAsFixed(2)}'),
              _buildSummaryRow(
                'Total:',
                'S/. ${total.toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 18,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 18,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final authBloc = BlocProvider.of<AuthBloc>(context);
          final authState = authBloc.state;

          if (authState is AuthUnauthenticated) {
            // Redirigir al login si no está autenticado
            Navigator.pushNamed(context, 'loginPage', arguments: {'nextPage': 'shoppingCart'});
            return;
          }

          if (authState is AuthAuthenticated) {
            final cartBloc = BlocProvider.of<CartBloc>(context);
            final state = cartBloc.state;

            if (state is CartLoaded && state.productos.isNotEmpty) {
              final List<Map<String, dynamic>> items = state.productos.map((producto) {
                final int cantidad = state.cantidades[producto.idRepuestos] ?? 1;
                return {
                  "title": producto.nombre,
                  "quantity": cantidad,
                  "unit_price": producto.precio,
                };
              }).toList();

              const double shippingCost = 18.00;

              try {
                final Uri url = Uri.http(ApiConfig.API, '/api/pago/create_preference');
                final HttpClient client = HttpClient();
                final HttpClientRequest request = await client.postUrl(url);

                request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
                request.add(utf8.encode(json.encode({"items": items, "shipping_cost": shippingCost})));

                final HttpClientResponse response = await request.close();

                if (response.statusCode == 200) {
                  final String responseBody = await response.transform(utf8.decoder).join();
                  final Map<String, dynamic> data = json.decode(responseBody);

                  if (data.containsKey('init_point')) {
                    final String initPoint = data['init_point'];

                    print('InitPoint recibido: $initPoint');

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentWebView(url: initPoint),
                      ),
                    );
                  } else {
                    print('Respuesta inesperada del backend: $data');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Error al obtener la URL de pago')),
                    );
                  }
                } else {
                  print('Error en la petición al backend. Código: ${response.statusCode}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error al conectar con el servidor')),
                  );
                }
              } catch (e) {
                print('Error en la conexión con el backend: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error al procesar el pago')),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('El carrito está vacío')),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Pagar',
          style: TextStyle(
            fontFamily: 'Oswald',
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}