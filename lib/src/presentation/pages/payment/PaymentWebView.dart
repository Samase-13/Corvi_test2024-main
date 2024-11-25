import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentWebView extends StatelessWidget {
  final String url;

  const PaymentWebView({Key? key, required this.url}) : super(key: key);

  Future<void> _launchUrl(BuildContext context) async {
    try {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir el enlace')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      appBar: AppBar(
        title: const Text(
          'Completar Pago',
          style: TextStyle(fontFamily: 'Oswald'),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Imagen principal
                Image.asset(
                  'assets/img/payment.png', // Ruta de la imagen principal
                  height: 180,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),

                // Título principal
                Text(
                  'Completa tu pago de manera segura',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Oswald',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                // Texto descriptivo
                const Text(
                  'Haz clic en el botón de abajo para completar tu pago en un entorno seguro. Una vez completado, volverás automáticamente a nuestra aplicación.',
                  style: TextStyle(fontSize: 16, fontFamily: 'Oswald'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Icono de pago seguro
                Image.asset(
                  'assets/img/secure_payment.png', // Ruta del ícono de seguridad
                  height: 80,
                ),
                const SizedBox(height: 30),

                // Botón de ir al pago
                ElevatedButton.icon(
                  onPressed: () => _launchUrl(context),
                  icon: const Icon(
                    Icons.payment,
                    size: 28,
                    color: Colors.white, // El ícono también será blanco
                  ),
                  label: const Text(
                    'Ir al pago',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Oswald',
                      color: Colors.white, // Texto blanco
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor, // Fondo del botón (debe contrastar)
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Nota de ayuda
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.info_outline, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      '¿Problemas con el pago? Contáctanos.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Oswald',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
