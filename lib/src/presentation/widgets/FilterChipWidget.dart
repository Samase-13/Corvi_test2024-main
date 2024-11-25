import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChipWidget(
      {super.key, required this.label,required this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 6.0), // Espacio entre los chips
      child: Material(
        color: isSelected
            ? const Color(0xFFFFC107) // Naranja cuando está seleccionado
            : const Color(0xFFBCBCBC), // Gris claro cuando no está seleccionado
        borderRadius: BorderRadius.circular(20),
        elevation: 10, // Mayor elevación para un sombreado más pronunciado
        shadowColor: Colors.black
            .withOpacity(0.6), // Color de la sombra con menor opacidad
        child: InkWell(
          borderRadius:
              BorderRadius.circular(20), // Aseguramos bordes redondeados
          onTap: onTap, // Puedes agregar la funcionalidad aquí
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 6), // Padding interno
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 15, // Tamaño del texto
                color: Colors.white, // Texto blanco en ambos estados
              ),
            ),
          ),
        ),
      ),
    );
  }
}
