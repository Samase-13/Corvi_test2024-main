import 'package:corvi_app/src/presentation/pages/machineryRental/MachineryRental.dart';
import 'package:corvi_app/src/presentation/pages/parts/PartsPage.dart';
import 'package:flutter/material.dart';
import 'package:corvi_app/src/presentation/pages/spareParts/SparePartsPage.dart';
import 'package:corvi_app/src/presentation/pages/shoppingCart/ShoppingCart.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0; // Para controlar el índice seleccionado

  // Lista de las páginas que se muestran en el `IndexedStack`
  final List<Widget> _pages = [
    SparePartsPage(), // Página de inicio
    PartsPage(), // Página de repuestos (esto es solo un ejemplo)
    MachineryRentalPage(), // Página de maquinaria (actualiza cuando tengas la página)
    ShoppingCart(), // Página del carrito de compras
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Actualiza el estado del índice seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex, // Muestra solo la página seleccionada
        children: _pages, // Las páginas se mantienen en memoria
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFFC107),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, // Muestra el índice seleccionado
        onTap: _onItemTapped, // Maneja el toque en los ítems
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Repuestos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.construction), label: 'Maquinaria'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Carrito'),
        ],
      ),
    );
  }
}
