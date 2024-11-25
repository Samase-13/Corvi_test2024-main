import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String productName;
  final VoidCallback onTap; // Callback para manejar el clic

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.onTap, // Requerimos el callback como parámetro
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Ejecutamos la función callback cuando se hace clic
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 300, // Ancho de la tarjeta
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // Bordes redondeados
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4), // Sombra suave
                spreadRadius: 2,
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ajuste dinámico de altura
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Ocupa todo el ancho
            children: [
              Expanded(
                // Usamos Expanded para que la imagen ocupe el espacio disponible
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20), // Redondeamos la imagen
                  child: CachedNetworkImage(
                    imageUrl: imagePath, // Imagen del producto
                    fit: BoxFit
                        .cover, // Ajuste de la imagen para cubrir el espacio disponible
                    placeholder: (context, url) => const Center(
                      child:
                          CircularProgressIndicator(), // Placeholder mientras la imagen carga
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error, // Icono en caso de error al cargar la imagen
                      color: Colors.red,
                      size: 50,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10), // Espacio entre la imagen y el texto
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0), // Padding para el texto
                child: Text(
                  productName, // Nombre del producto
                  style: const TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 16, // Tamaño del texto
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center, // Centrar el texto
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
