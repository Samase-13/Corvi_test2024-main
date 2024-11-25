import 'package:corvi_app/src/domain/models/Maquinarias.dart';
import 'package:corvi_app/src/presentation/pages/machineryRental/bloc/MaquinariaBloc.dart';
import 'package:corvi_app/src/presentation/pages/machineryRental/bloc/MaquinariaEvent.dart';
import 'package:corvi_app/src/presentation/pages/machineryRental/bloc/MaquinariaState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corvi_app/src/presentation/widgets/FilterChipWidget.dart';
import 'package:corvi_app/src/presentation/widgets/ProductCard.dart';
import 'package:corvi_app/src/presentation/widgets/SectionTitle.dart';
import '../auth/bloc/AuthBloc.dart';
import '../auth/bloc/AuthEvent.dart';
import '../auth/bloc/AuthState.dart';

class MachineryRentalPage extends StatefulWidget {
  const MachineryRentalPage({super.key});

  @override
  _MachineryRentalPageState createState() => _MachineryRentalPageState();
}

class _MachineryRentalPageState extends State<MachineryRentalPage> {
  @override
  void initState() {
    super.initState();
    // Verificar el estado de la sesión al iniciar la página
    context.read<AuthBloc>().add(CheckAuthStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    final maquinariaBloc = BlocProvider.of<MaquinariaBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30), // Espaciado adicional en la parte superior
                _buildHeader(context),
                const SizedBox(height: 20),
                _buildSearchAndFilterRow(),
                const SizedBox(height: 20),
                _buildFilterChips(),
                const SizedBox(height: 20),
                BlocBuilder<MaquinariaBloc, MaquinariaState>(
                  builder: (context, state) {
                    if (state is MaquinariaLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MaquinariaLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMaquinariaSection(
                            context,
                            maquinariaBloc,
                            'Excavadoras',
                            state.maquinaria,
                          ),
                          _buildMaquinariaSection(
                            context,
                            maquinariaBloc,
                            'Cargadores',
                            state.maquinaria,
                          ),
                          _buildMaquinariaSection(
                            context,
                            maquinariaBloc,
                            'Bulldozers',
                            state.maquinaria,
                          ),
                          _buildMaquinariaSection(
                            context,
                            maquinariaBloc,
                            'Retroexcavadora',
                            state.maquinaria,
                          ),
                          _buildMaquinariaSection(
                            context,
                            maquinariaBloc,
                            'Rodillos Compactadores',
                            state.maquinaria,
                          ),
                          _buildMaquinariaSection(
                            context,
                            maquinariaBloc,
                            'Camiones de Volquete',
                            state.maquinaria,
                          ),
                          _buildMaquinariaSection(
                            context,
                            maquinariaBloc,
                            'Tractores',
                            state.maquinaria,
                          ),
                        ],
                      );
                    } else if (state is MaquinariaError) {
                      return Center(child: Text('Error al cargar maquinaria'));
                    }
                    return Container(); // Estado inicial
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para construir cada sección de maquinaria según el tipo
  Widget _buildMaquinariaSection(BuildContext context, MaquinariaBloc bloc,
      String tipo, List<Maquinaria> maquinaria) {
    final maquinariaFiltrada = bloc.filtrarMaquinariaPorTipo(maquinaria, tipo);

    if (maquinariaFiltrada.isEmpty) {
      return Container(); // Si no hay maquinaria del tipo, no se muestra
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: tipo,
          showSeeAll: false, // No mostramos "Ver todos"
        ),
        const SizedBox(height: 10),
        _buildHorizontalListView(maquinariaFiltrada),
        const SizedBox(height: 20),
      ],
    );
  }

  // Widget para construir el encabezado (logo y perfil) con el menú desplegable
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CorviTrack',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontFamily: 'Oswald',
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Maquinaria a tu alcance, siempre.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontFamily: 'Montserrat',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF7A7A7A),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return PopupMenuButton<int>(
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                  size: 70,
                ),
                onSelected: (int value) {
                  switch (value) {
                    case 0:
                      Navigator.pushNamed(context, 'loginPage');
                      break;
                    case 1:
                      Navigator.pushNamed(context, 'profile');
                      break;
                    case 2:
                      Navigator.pushNamed(context, 'settings');
                      break;
                    case 3:
                      context.read<AuthBloc>().add(LogoutEvent());
                      break;
                  }
                },
                itemBuilder: (context) => [
                  if (state is AuthAuthenticated &&
                      state.userName != null &&
                      state.userApellido != null) ...[
                    PopupMenuItem<int>(
                      enabled: false, // No interactivo
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.userName} ${state.userApellido}',
                            style: const TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Divider(color: Colors.grey), // Línea divisoria
                        ],
                      ),
                    ),
                  ],
                  if (state is AuthUnauthenticated) ...[
                    PopupMenuItem<int>(
                      value: 0,
                      child: const Text('Iniciar Sesión'),
                    ),
                  ] else if (state is AuthAuthenticated) ...[
                    PopupMenuItem<int>(
                      value: 3,
                      child: const Text('Cerrar Sesión'),
                    ),
                  ],
                  PopupMenuItem<int>(
                    value: 1,
                    child: const Text('Perfil'),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: const Text('Configuración'),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget para construir el TextField de búsqueda y el botón de filtro
  Widget _buildSearchAndFilterRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: Colors.black, size: 30),
                hintText: 'Buscar',
                hintStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Oswald',
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFC107),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(Icons.tune, color: Colors.black, size: 30),
        ),
      ],
    );
  }
  // Widget para construir los Filter Chips
  Widget _buildFilterChips() {
  final maquinariaBloc = BlocProvider.of<MaquinariaBloc>(context);

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        FilterChipWidget(
          label: 'Todos',
          isSelected: true,
          onTap: () {
            maquinariaBloc.add(const FetchMaquinaria());
          },
        ),
        FilterChipWidget(
          label: 'Excavadoras',
          onTap: () {
            maquinariaBloc.add(const FetchFilteredMaquinaria('Excavadoras'));
          },
        ),
        FilterChipWidget(
          label: 'Cargadores',
          onTap: () {
            maquinariaBloc.add(const FetchFilteredMaquinaria('Cargadores'));
          },
        ),
        FilterChipWidget(
          label: 'Bulldozers',
          onTap: () {
            maquinariaBloc.add(const FetchFilteredMaquinaria('Bulldozers'));
          },
        ),
        FilterChipWidget(
          label: 'Retroexcavadora',
          onTap: () {
            maquinariaBloc.add(const FetchFilteredMaquinaria('Retroexcavadora'));
          },
        ),
        FilterChipWidget(
          label: 'Rodillos Compactadores',
          onTap: () {
            maquinariaBloc.add(const FetchFilteredMaquinaria('Rodillos Compactadores'));
          },
        ),
        FilterChipWidget(
          label: 'Camiones de Volquete',
          onTap: () {
            maquinariaBloc.add(const FetchFilteredMaquinaria('Camiones de Volquete'));
          },
        ),
        FilterChipWidget(
          label: 'Tractores',
          onTap: () {
            maquinariaBloc.add(const FetchFilteredMaquinaria('Tractores'));
          },
        ),
      ],
    ),
  );
}



  // Widget para construir la lista horizontal de maquinaria
  Widget _buildHorizontalListView(List<Maquinaria> maquinaria) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: maquinaria.length,
        itemBuilder: (context, index) {
          final item = maquinaria[index];
          return ProductCard(
            imagePath: item.img,
            productName: item.nombre,
            onTap: () {
              Navigator.pushNamed(
                context,
                'descriptionMachinery',
                arguments: item.idMaquinaria,
              );
            },
          );
        },
      ),
    );
  }
}
