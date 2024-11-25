import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/MachineryBloc.dart';
import 'bloc/MachineryState.dart';
import 'bloc/MachineryEvent.dart';

class MachineryDetailsPage extends StatelessWidget {
  const MachineryDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final idMachinery = ModalRoute.of(context)!.settings.arguments as int;

    context.read<MachineryBloc>().add(FetchMachineryDescription(idMachinery));

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
      body: BlocBuilder<MachineryBloc, MachineryState>(
        builder: (context, state) {
          if (state is MachineryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MachineryLoaded) {
            final maquinaria = state.maquinaria;
            final isHourlySelected = state.isHourlySelected;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    maquinaria.img,
                    height: 450,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    maquinaria.nombre,
                    style: const TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    maquinaria.descripcion,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Tipo',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            maquinaria.tipo,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Estado',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            maquinaria.estado
                                .toUpperCase(), // Convertir el estado a mayúsculas
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Precio por hora',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<MachineryBloc>()
                                  .add(TogglePriceSelection(true));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isHourlySelected
                                  ? const Color(0xFFFFC107)
                                  : Colors.white,
                              side: const BorderSide(
                                  color: Color(0xFFFFC107), width: 2),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'S/. ${maquinaria.precioHora.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                color: isHourlySelected
                                    ? Colors.black
                                    : const Color(0xFFFFC107),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Precio por día',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<MachineryBloc>()
                                  .add(TogglePriceSelection(false));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: !isHourlySelected
                                  ? const Color(0xFFFFC107)
                                  : Colors.white,
                              side: const BorderSide(
                                  color: Color(0xFFFFC107), width: 2),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'S/. ${maquinaria.precioDia.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                color: !isHourlySelected
                                    ? Colors.black
                                    : const Color(0xFFFFC107),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (maquinaria.estado.toLowerCase() == "disponible") {
                        // Redirige solo si está disponible
                        final price = isHourlySelected
                            ? maquinaria.precioHora
                            : maquinaria.precioDia;
                        final priceType =
                            isHourlySelected ? "por hora" : "por día";

                        Navigator.pushNamed(
                          context,
                          'rentalCart',
                          arguments: {
                            'img': maquinaria.img,
                            'nombre': maquinaria.nombre,
                            'tipo': maquinaria.tipo,
                            'precio': price,
                            'precioTipo': priceType,
                          },
                        );
                      } else {
                        // Muestra una alerta si está ocupado
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Maquinaria No Disponible"),
                              content: const Text(
                                  "Esta maquinaria está ocupada en este momento."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
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
                      'Alquilar',
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
            );
          } else if (state is MachineryError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Container();
        },
      ),
    );
  }
}
