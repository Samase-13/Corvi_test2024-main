import 'package:corvi_app/src/domain/models/Repuestos.dart';
import 'package:corvi_app/src/presentation/pages/machineryRental/bloc/MaquinariaBloc.dart';
import 'package:corvi_app/src/presentation/pages/machineryRental/bloc/MaquinariaEvent.dart';
import 'package:corvi_app/src/presentation/pages/spareParts/bloc/RepuestosBloc.dart';
import 'package:corvi_app/src/presentation/pages/spareParts/bloc/RepuestosState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corvi_app/src/presentation/widgets/FilterChipWidget.dart';
import 'package:corvi_app/src/presentation/widgets/ProductCard.dart';
import 'package:corvi_app/src/presentation/widgets/SectionTitle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/bloc/AuthBloc.dart';
import '../auth/bloc/AuthState.dart';
import '../auth/bloc/AuthEvent.dart';

class PartsPage extends StatefulWidget {
  const PartsPage({super.key});

  @override
  _PartsPageState createState() => _PartsPageState();
}

class _PartsPageState extends State<PartsPage> {
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
    _getUserInfo().then((userInfo) {
      setState(() {
        userName = userInfo['name'];
        userApellido = userInfo['apellido'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                BlocBuilder<RepuestosBloc, RepuestosState>(
                  builder: (context, state) {
                    if (state is RepuestosLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is RepuestosLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionTitle(
                            title: 'Electrobombas',
                            showSeeAll: false,
                          ),
                          const SizedBox(height: 10),
                          _buildHorizontalListView(
                              filtrarRepuestosPorCategoria(
                                  state.repuestos, 'Electrobombas')),
                          const SizedBox(height: 20),
                          SectionTitle(
                            title: 'Compresores y Filtros',
                            showSeeAll: false,
                          ),
                          const SizedBox(height: 10),
                          _buildHorizontalListView(
                              filtrarRepuestosPorCategoria(
                                  state.repuestos, 'Compresores y Filtros')),
                          const SizedBox(height: 20),
                          SectionTitle(
                            title: 'Contactores de Alta Capacidad',
                            showSeeAll: false,
                          ),
                          const SizedBox(height: 10),
                          _buildHorizontalListView(
                              filtrarRepuestosPorCategoria(
                                  state.repuestos, 'Contactores de Alta Capacidad')),
                          const SizedBox(height: 20),
                          SectionTitle(
                            title: 'Contactores de Baja Capacidad',
                            showSeeAll: false,
                          ),
                          const SizedBox(height: 10),
                          _buildHorizontalListView(
                              filtrarRepuestosPorCategoria(
                                  state.repuestos, 'Contactores de Baja Capacidad')),
                          const SizedBox(height: 20),
                          SectionTitle(
                            title: 'Capacitores de Trabajo (Alta Capacidad)',
                            showSeeAll: false,
                          ),
                          const SizedBox(height: 10),
                          _buildHorizontalListView(
                              filtrarRepuestosPorCategoria(
                                  state.repuestos, 'Capacitores de Trabajo (Alta Capacidad)')),
                          const SizedBox(height: 20),
                          SectionTitle(
                            title: 'Capacitores de Trabajo (Baja Capacidad)',
                            showSeeAll: false,
                          ),
                          const SizedBox(height: 10),
                          _buildHorizontalListView(
                              filtrarRepuestosPorCategoria(
                                  state.repuestos, 'Capacitores de Trabajo (Baja Capacidad)')),
                          const SizedBox(height: 20),
                          SectionTitle(
                            title: 'Capacitores de Arranque (Alta Capacidad)',
                            showSeeAll: false,
                          ),
                          const SizedBox(height: 10),
                          _buildHorizontalListView(
                              filtrarRepuestosPorCategoria(
                                  state.repuestos, 'Capacitores de Arranque (Alta Capacidad)')),
                          const SizedBox(height: 20),
                          SectionTitle(
                            title: 'Capacitores de Arranque (Baja Capacidad)',
                            showSeeAll: false,
                          ),
                          const SizedBox(height: 10),
                          _buildHorizontalListView(
                              filtrarRepuestosPorCategoria(
                                  state.repuestos, 'Capacitores de Arranque (Baja Capacidad)')),
                        ],
                      );
                    } else if (state is RepuestosError) {
                      return Center(child: Text('Error al cargar repuestos'));
                    }
                    return Container(); // Estado inicial
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Repuesto> filtrarRepuestosPorCategoria(
      List<Repuesto> repuestos, String categoria) {
    switch (categoria) {
      case 'Electrobombas':
        return repuestos.where((r) => r.nombre.contains('Electrobomba')).toList();
      case 'Compresores y Filtros':
        return repuestos.where((r) => r.nombre.contains('Compresor') || r.nombre.contains('Filtro')).toList();
      case 'Contactores de Alta Capacidad':
        return repuestos.where((r) => r.nombre.contains('Chint') && (r.nombre.contains('115 A') || r.nombre.contains('80 A') || r.nombre.contains('65 A'))).toList();
      case 'Contactores de Baja Capacidad':
        return repuestos.where((r) => r.nombre.contains('Chint') && (r.nombre.contains('50 A') || r.nombre.contains('40 A') || r.nombre.contains('32 A') || r.nombre.contains('25 A') || r.nombre.contains('18 A') || r.nombre.contains('12 A'))).toList();
      case 'Capacitores de Trabajo (Alta Capacidad)':
        return repuestos.where((r) => r.nombre.contains('Capacitor Trabajo') && (r.nombre.contains('25') || r.nombre.contains('30') || r.nombre.contains('35') || r.nombre.contains('40') || r.nombre.contains('45') || r.nombre.contains('50'))).toList();
      case 'Capacitores de Trabajo (Baja Capacidad)':
        return repuestos.where((r) => r.nombre.contains('Capacitor Trabajo') && (r.nombre.contains('5') || r.nombre.contains('8') || r.nombre.contains('10') || r.nombre.contains('12') || r.nombre.contains('15') || r.nombre.contains('16') || r.nombre.contains('17') || r.nombre.contains('20'))).toList();
      case 'Capacitores de Arranque (Alta Capacidad)':
        return repuestos.where((r) => r.nombre.contains('Capacitor Arranque') && (r.nombre.contains('124-149') || r.nombre.contains('189-227') || r.nombre.contains('200-240') || r.nombre.contains('250'))).toList();
      case 'Capacitores de Arranque (Baja Capacidad)':
        return repuestos.where((r) => r.nombre.contains('Capacitor Arranque') && (r.nombre.contains('72-86') || r.nombre.contains('108-130'))).toList();
      default:
        return repuestos;
    }
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


  Widget _buildHorizontalListView(List<dynamic> repuestos) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: repuestos.length,
        itemBuilder: (context, index) {
          final repuesto = repuestos[index];
          return ProductCard(
            imagePath: repuesto.imagen,
            productName: repuesto.nombre,
            onTap: () {
              Navigator.pushNamed(
                context,
                'descriptionParts',
                arguments: repuesto.idRepuestos,
              );
            },
          );
        },
      ),
    );
  }
}
