import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/AuthBloc.dart';
import '../bloc/AuthEvent.dart';
import '../bloc/AuthState.dart';
import '../login/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Oswald', // Configura Oswald como la fuente predeterminada
      ),
      initialRoute: 'registerPage',
      routes: {
        'loginPage': (context) => const LoginPage(),
        'registerPage': (context) => const RegisterPage(),
      },
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isPasswordVisible = false; // Variable para mostrar/ocultar la contraseña

  // Controladores de los campos de texto
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              print("Registro exitoso: ${state.message}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pushNamed(context, 'loginPage');
            } else if (state is AuthFailure) {
              print("Error en el registro: ${state.message}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    // Forma curva con gradiente en la parte superior
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 250,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFFFE084), // Primer color en 0%
                              Color(0xFFFFC107),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/icon/logo-c.png', // Ruta de la imagen
                              width: 150, // Tamaño de la imagen
                              height: 150,
                            ),
                            Transform.translate(
                              offset: const Offset(0, -10), // Ajuste de posición del texto
                              child: const Text(
                                'CorviTrack',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 320.0), // Ajusta el espacio debajo de la curva
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Crea una Cuenta',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Nombres TextField
                              _buildTextField(_nombreController, 'Nombres'),
                              const SizedBox(height: 16),

                              // Apellidos TextField
                              _buildTextField(_apellidoController, 'Apellidos'),
                              const SizedBox(height: 16),

                              // Número Telefónico TextField
                              _buildTextField(_telefonoController, 'Número Telefónico', keyboardType: TextInputType.phone),
                              const SizedBox(height: 16),

                              // Correo Electrónico TextField
                              _buildTextField(_correoController, 'Correo Electrónico', keyboardType: TextInputType.emailAddress),
                              const SizedBox(height: 16),

                              // Contraseña TextField con mostrar/ocultar
                              _buildPasswordField(),

                              const SizedBox(height: 24),

                              // Register Button
                              OutlinedButton(
                                onPressed: _register,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  side: const BorderSide(color: Color(0xFFFFC107)), // Color del borde
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize: const Size.fromHeight(50),
                                ),
                                child: const Text(
                                  'Registrarse',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, // Aplica negrita
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Divider con OR
                              Row(
                                children: const [
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      'O',
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Sign In Link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '¿Ya tienes una cuenta?',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, 'loginPage'); // Navega a la ruta de inicio de sesión
                                    },
                                    child: const Text(
                                      'Inicia Sesión',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Social Media Login Options
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                                  SizedBox(width: 16),
                                  FaIcon(FontAwesomeIcons.linkedin, color: Colors.blue),
                                  SizedBox(width: 16),
                                  FaIcon(FontAwesomeIcons.twitter, color: Colors.blue),
                                  SizedBox(width: 16),
                                  FaIcon(FontAwesomeIcons.google, color: Colors.red),
                                ],
                              ),
                            ],
                          ),
                        ),
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

  // Método para construir el campo de texto común
  Widget _buildTextField(TextEditingController controller, String hint, {TextInputType keyboardType = TextInputType.text}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[600]),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Método para construir el campo de contraseña
  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _passwordController,
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
          hintText: 'Contraseña',
          hintStyle: TextStyle(color: Colors.grey[600]),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  // Método para realizar el registro
  void _register() {
    print("Intentando registrarse con los datos: ");
    print("Nombres: ${_nombreController.text}");
    print("Correo: ${_correoController.text}");
    print("Contraseña: ${_passwordController.text}");

    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(RegisterEvent(
      nombres: _nombreController.text,
      apellido: _apellidoController.text,
      numeroTelefonico: _telefonoController.text,
      correo: _correoController.text,
      password: _passwordController.text,
    ));
  }
}
