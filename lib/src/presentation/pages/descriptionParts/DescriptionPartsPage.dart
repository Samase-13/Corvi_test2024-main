import 'package:corvi_app/src/presentation/pages/shoppingCart/bloc/CartBloc.dart';
import 'package:corvi_app/src/presentation/pages/shoppingCart/bloc/CartEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/DescriptionPartsBloc.dart';
import 'bloc/DescriptionPartsState.dart';
import 'bloc/DescriptionPartsEvent.dart'; // Importación del archivo de eventos

class DescriptionPartsPage extends StatelessWidget {
  const DescriptionPartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtén el id del repuesto de los argumentos que se pasaron
    final partId = ModalRoute.of(context)!.settings.arguments as int;

    // Dispara el evento del Bloc para obtener la descripción del repuesto usando el id
    context.read<DescriptionPartsBloc>().add(FetchPartDescription(partId));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          iconSize: 30,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            iconSize: 30,
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<DescriptionPartsBloc, DescriptionPartsState>(
        builder: (context, state) {
          if (state is DescriptionPartsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DescriptionPartsLoaded) {
            final repuesto = state.repuesto;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      repuesto.imagen,
                      height: 450, // Ajuste de la altura de la imagen
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      repuesto.nombre,
                      style: const TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      repuesto.descripcion,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                      height:
                          70), // Mayor separación entre la descripción y el resto
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Stock',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Disponible',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cantidad',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              _buildQuantityButton(Icons.remove, () {
                                context
                                    .read<DescriptionPartsBloc>()
                                    .add(const DecrementQuantity());
                              }),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: BlocBuilder<DescriptionPartsBloc,
                                    DescriptionPartsState>(
                                  builder: (context, state) {
                                    int quantity = 0;
                                    if (state is DescriptionPartsLoaded) {
                                      quantity = state.quantity;
                                    }
                                    return Text(
                                      '$quantity', // Cantidad seleccionada
                                      style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              _buildQuantityButton(Icons.add, () {
                                context
                                    .read<DescriptionPartsBloc>()
                                    .add(const IncrementQuantity());
                              }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC107),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'S/. ${repuesto.precio.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final currentState =
                                context.read<DescriptionPartsBloc>().state;
                            if (currentState is DescriptionPartsLoaded) {
                              context.read<CartBloc>().add(
                                    AddProductToCart(currentState.repuesto,
                                        currentState.quantity),
                                  );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        '${currentState.repuesto.nombre} agregado al carrito')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFBCBCBC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                          ),
                          child: const Text(
                            'Agregar al Carrito',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Espacio adicional para separar elementos
                ],
              ),
            );
          } else if (state is DescriptionPartsError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Container();
        },
      ),
    );
  }

  // Método para crear los botones de cantidad
  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFC107),
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
