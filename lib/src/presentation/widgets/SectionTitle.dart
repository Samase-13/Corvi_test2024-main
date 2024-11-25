import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final bool showSeeAll;
  final VoidCallback? onSeeAllTap; // Nueva función de callback para "Ver todos"

  const SectionTitle({
    super.key,
    required this.title,
    this.showSeeAll = true,
    this.onSeeAllTap, // Acepta una función opcional para manejar la navegación
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        if (showSeeAll)
          GestureDetector(
            onTap: onSeeAllTap, // Navegación al hacer clic en "Ver todos"
            child: Text(
              'Ver todos',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }
}
