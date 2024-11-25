import 'package:corvi_app/src/domain/models/Maquinarias.dart';
import 'package:corvi_app/src/domain/models/Repuestos.dart';
import 'package:corvi_app/src/presentation/pages/machineryRental/bloc/MaquinariaEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corvi_app/src/presentation/pages/spareParts/bloc/RepuestosBloc.dart';
import 'package:corvi_app/src/presentation/pages/spareParts/bloc/RepuestosState.dart';
import 'package:corvi_app/src/presentation/pages/machineryRental/bloc/MaquinariaBloc.dart';
import 'package:corvi_app/src/presentation/pages/machineryRental/bloc/MaquinariaState.dart';
import 'package:corvi_app/src/presentation/widgets/FilterChipWidget.dart';
import 'package:corvi_app/src/presentation/widgets/ProductCard.dart';
import 'package:corvi_app/src/presentation/widgets/SectionTitle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/bloc/AuthBloc.dart';
import '../auth/bloc/AuthEvent.dart';
import '../auth/bloc/AuthState.dart';

class SparePartsPage extends StatefulWidget {
  const SparePartsPage({super.key});

  @override
  _SparePartsPageState createState() => _SparePartsPageState();
}

class _SparePartsPageState extends State<SparePartsPage> {
  String? userName;
  String? userApellido;

  // Recuperar nombre y apellido desde SharedPreferences
  Future<Map<String, String>> _getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userName') ?? '';
    final apellido = prefs.getString('userApellido') ?? '';
    return {'name': name, 'apellido': apellido};
  }

  // Eliminar nombre y apellido al hacer logout
  Future<void> _clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userName');
    prefs.remove('userApellido');
    setState(() {
      userName = null;
      userApellido = null;
    });
  }

  @override
  void initState() {
    super.initState();

    // Llama al evento solo una vez
    Future.microtask(() {
      context.read<AuthBloc>().add(CheckAuthStatusEvent());
    });

    // Recupera la información del usuario
    _getUserInfo().then((userInfo) {
      setState(() {
        userName = userInfo['name'];
        userApellido = userInfo['apellido'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Verificar el estado de la sesión al iniciar la página
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
                const SizedBox(height: 30),
                _buildHeader(context),
                const SizedBox(height: 20),
                _buildSearchAndFilterRow(),
                const SizedBox(height: 20),
                _buildFilterChips(),
                const SizedBox(height: 20),
                SectionTitle(
                  title: 'Repuestos',
                  showSeeAll: true,
                  onSeeAllTap: () {
                    Navigator.pushNamed(context, 'parts');
                  },
                ),
                const SizedBox(height: 10),
                BlocBuilder<RepuestosBloc, RepuestosState>(
                  builder: (context, state) {
                    if (state is RepuestosLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is RepuestosLoaded) {
                      return _buildHorizontalListView(state.repuestos);
                    } else if (state is RepuestosError) {
                      return Center(child: Text('Error al cargar repuestos'));
                    }
                    return const Center(
                        child: Text('No hay repuestos disponibles'));
                  },
                ),
                const SizedBox(height: 20),
                SectionTitle(
                  title: 'Reservar Maquinaria',
                  showSeeAll: true,
                  onSeeAllTap: () {
                    Navigator.pushNamed(context, 'maquinaria');
                  },
                ),
                const SizedBox(height: 10),
                BlocBuilder<MaquinariaBloc, MaquinariaState>(
                  builder: (context, state) {
                    if (state is MaquinariaLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MaquinariaLoaded) {
                      return _buildHorizontalListView(state.maquinaria);
                    } else if (state is MaquinariaError) {
                      return Center(child: Text('Error al cargar maquinaria'));
                    }
                    return const Center(
                        child: Text('No hay maquinaria disponible'));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                PopupMenuButton<int>(
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
                        _clearUserInfo(); // Limpiar datos del usuario
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    // Mostrar nombre y apellido si el usuario está autenticado
                    if (userName != null && userApellido != null) ...[
                      PopupMenuItem<int>(
                        enabled: false, // No interactivo
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$userName $userApellido',
                              style: const TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Divider(
                                color: Colors.grey), // Línea divisoria
                          ],
                        ),
                      ),
                    ],
                    // Opciones del menú
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
                ),
              ],
            );
          },
        ),
      ],
    );
  }

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
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon:
                    const Icon(Icons.search, color: Colors.black, size: 30),
                hintText: 'Buscar',
                hintStyle: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Oswald',
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(
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
          child: const Icon(Icons.tune, color: Colors.black, size: 30),
        ),
      ],
    );
  }

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


  Widget _buildHorizontalListView(List<dynamic> items) {
    final limitedItems =
        items.take(5).toList(); // Limitar a los primeros 5 elementos

    return SizedBox(
      height: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: limitedItems.length,
        itemBuilder: (context, index) {
          final item = limitedItems[index];
          String imagePath;
          String productName;
          int itemId;
          String routeName;

          if (item is Repuesto) {
            imagePath = item.imagen;
            productName = item.nombre;
            itemId = item.idRepuestos;
            routeName = 'descriptionParts';
          } else if (item is Maquinaria) {
            imagePath = item.img;
            productName = item.nombre;
            itemId = item.idMaquinaria;
            routeName = 'descriptionMachinery';
          } else {
            return Container();
          }

          return ProductCard(
            imagePath: imagePath,
            productName: productName,
            onTap: () {
              Navigator.pushNamed(
                context,
                routeName,
                arguments: itemId,
              );
            },
          );
        },
      ),
    );
  }
}
