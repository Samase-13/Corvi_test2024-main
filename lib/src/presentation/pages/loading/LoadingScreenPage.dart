import 'package:flutter/material.dart';

class LoadingScreenPage extends StatefulWidget {
  const LoadingScreenPage({super.key});

  @override
  _LoadingScreenPageState createState() => _LoadingScreenPageState();
}

class _LoadingScreenPageState extends State<LoadingScreenPage> {
  @override
  void initState() {
    super.initState();
    // Simulamos un delay de 3 segundos para cargar la app
    Future.delayed(Duration(seconds: 3), () {
      // Después de 3 segundos, navegamos a la página de SpareParts
      Navigator.pushReplacementNamed(context, 'main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFE084), // Primer color en 0%
              Color(0xFFFFC107), // Segundo color en 38%
            ],
            stops: [0.0, 0.38], // Definimos los stops del gradiente
            begin:
                Alignment.topLeft, // Comienza en la esquina superior izquierda
            end:
                Alignment.bottomRight, // Termina en la esquina inferior derecha
          ),
        ),
        child: Stack(
          children: [
            // Imagen con opacidad en la parte inferior izquierda
            Positioned(
              bottom: 0,
              left: 0,
              child: FractionalTranslation(
                translation: Offset(
                  -0.01,
                  0.12,
                ), // Mueve la imagen ligeramente en función de su tamaño
                child: Opacity(
                  opacity: 0.8, // Aplica la opacidad del 80%
                  child: Image.asset(
                    'assets/img/loading-img.png',
                    height: 300,
                    fit: BoxFit.contain, // Ajusta el tamaño de la imagen
                  ),
                ),
              ),
            ),

            // Texto en el centro
            Center(
              child: Text(
                'CorviTrack',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.bold,
                  fontSize: 85,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
