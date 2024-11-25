import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corvi_app/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:corvi_app/src/presentation/pages/auth/register/RegisterPage.dart';
import 'package:corvi_app/src/presentation/pages/descriptionParts/DescriptionPartsPage.dart';
import 'package:corvi_app/src/presentation/pages/loading/LoadingScreenPage.dart';
import 'package:corvi_app/src/presentation/pages/machineryDetail/MachineryDetailsPage.dart';
import 'package:corvi_app/src/presentation/pages/machineryRental/MachineryRental.dart';
import 'package:corvi_app/src/presentation/pages/parts/PartsPage.dart';
import 'package:corvi_app/src/presentation/pages/rentalCart/RentalCartPage.dart';
import 'package:corvi_app/src/presentation/pages/shoppingCart/ShoppingCart.dart';
import 'package:corvi_app/src/presentation/pages/spareParts/SparePartsPage.dart';
import 'package:corvi_app/src/presentation/widgets/MainNavigationPage.dart';
import 'package:corvi_app/injection.dart'; // Inyección de dependencias
import 'package:corvi_app/src/presentation/pages/blocProviders.dart'; // BlocProviders
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencias(); // Configurar dependencias
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders, // Proveer los BLoCs
      child: MaterialApp(
        builder: FToastBuilder(), // Para mostrar toasts si es necesario
        debugShowCheckedModeBanner: false,
        title: 'CorviTrack',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        initialRoute: 'loading', // Ya no redirigimos a login por defecto
        routes: {
          'loading': (BuildContext context) => LoadingScreenPage(),
          'main': (BuildContext context) => const MainNavigationPage(),
          'spareParts': (BuildContext context) => SparePartsPage(),
          'descriptionParts': (BuildContext context) => DescriptionPartsPage(),
          'shoppingCart': (BuildContext context) => ShoppingCart(),
          'parts': (BuildContext context) => PartsPage(),
          'machineryRental': (BuildContext context) => MachineryRentalPage(),
          'descriptionMachinery': (BuildContext context) => MachineryDetailsPage(),
          'rentalCart': (BuildContext context) => RentalCartPage(),
          'loginPage': (BuildContext context) => LoginPage(),
          'registerPage': (BuildContext context) => RegisterPage(),
        },
      ),
    );
  }
}
