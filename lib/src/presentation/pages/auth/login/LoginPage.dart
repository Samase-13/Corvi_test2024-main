import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/AuthBloc.dart';
import '../bloc/AuthEvent.dart';
import '../bloc/AuthState.dart';
import '../register/RegisterPage.dart';

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
      initialRoute: 'loginPage', // Ruta inicial
      routes: {
        'loginPage': (context) => const LoginPage(),
        'registerPage': (context) => const RegisterPage(), // Ruta de la página de registro
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  final String? nextPage;

  const LoginPage({super.key, this.nextPage});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool rememberMe = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                            Color(0xFFFFE084),
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
                            'assets/img/icon/logo-c.png',
                            width: 150,
                            height: 150,
                          ),
                          Transform.translate(
                            offset: const Offset(0, -10),
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
                    padding: const EdgeInsets.only(top: 380.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthAuthenticated) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Inicio de sesión exitoso')),
                              );

                              // Verifica que solo navegue una vez
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (widget.nextPage != null) {
                                  Navigator.pushReplacementNamed(context, widget.nextPage!);
                                } else {
                                  Navigator.pushReplacementNamed(context, 'main');
                                }
                              });
                            } else if (state is AuthFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                          },
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  '¡Bienvenido de Regreso!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Username TextField
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      hintText: 'Correo Electrónico',
                                      hintStyle: TextStyle(color: Colors.grey[600]),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Password TextField
                                Container(
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
                                ),
                                const SizedBox(height: 16),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: rememberMe,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              rememberMe = value ?? false;
                                            });
                                          },
                                          activeColor: Colors.yellow,
                                        ),
                                        const Text(
                                          'Recordarme',
                                          style: TextStyle(color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      '¿Olvidó su Contraseña?',
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                if (state is AuthLoading)
                                  const CircularProgressIndicator()
                                else
                                  OutlinedButton(
                                    onPressed: () {
                                      final email = _emailController.text.trim();
                                      final password = _passwordController.text.trim();

                                      context.read<AuthBloc>().add(
                                        LoginEvent(email, password),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      side: const BorderSide(color: Color(0xFFFFC107)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      minimumSize: const Size.fromHeight(50),
                                    ),
                                    child: const Text(
                                      'Iniciar Sesión',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 16),

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

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '¿Nuevo Usuario?',
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, 'registerPage');
                                      },
                                      child: const Text(
                                        'Regístrate',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

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
                            );
                          },
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
    );
  }
}
