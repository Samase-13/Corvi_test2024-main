import 'package:corvi_app/src/domain/useCases/Ruc/FecthRucUseCase.dart';
import 'package:corvi_app/src/presentation/pages/calendar/bloc/DisponibilidadBloc.dart';
import 'package:corvi_app/src/presentation/pages/machineryDetail/bloc/MachineryBloc.dart';
import 'package:corvi_app/src/presentation/pages/ruc/bloc/RucBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corvi_app/injection.dart'; // Archivo de inyección de dependencias

// Importaciones de los Blocs y UseCases
import 'package:corvi_app/src/presentation/pages/spareParts/bloc/RepuestosBloc.dart';
import 'package:corvi_app/src/presentation/pages/spareParts/bloc/RepuestosEvent.dart';
import 'package:corvi_app/src/domain/useCases/repuestos/RepuestosUseCases.dart';

import 'package:corvi_app/src/presentation/pages/machineryRental/bloc/MaquinariaBloc.dart';
import 'package:corvi_app/src/presentation/pages/machineryRental/bloc/MaquinariaEvent.dart';
import 'package:corvi_app/src/domain/useCases/maquinaria/MaquinariaUseCases.dart';

import 'package:corvi_app/src/presentation/pages/descriptionParts/bloc/DescriptionPartsBloc.dart';
import 'package:corvi_app/src/presentation/pages/shoppingCart/bloc/CartBloc.dart';
import 'package:corvi_app/src/domain/useCases/disponibilidad/GuardarDisponibilidadUseCase.dart';

import '../../domain/useCases/auth/AuthUseCases.dart';
import 'auth/bloc/AuthBloc.dart';

// Lista de BlocProviders para tu aplicación
List<BlocProvider> blocProviders = [
  // Proveedor del RepuestosBloc
  BlocProvider<RepuestosBloc>(
    create: (context) =>
        RepuestosBloc(locator<RepuestosUseCases>())..add(FetchRepuestos()),
  ),
  // Proveedor del MaquinariaBloc
  BlocProvider<MaquinariaBloc>(
    create: (context) =>
        MaquinariaBloc(locator<MaquinariaUseCases>())..add(FetchMaquinaria()),
  ),
  // Proveedor del DescriptionPartsBloc
  BlocProvider<DescriptionPartsBloc>(
    create: (context) => DescriptionPartsBloc(locator<RepuestosUseCases>()),
  ),
  // Proveedor del CartBloc
  BlocProvider<CartBloc>(
    create: (context) => CartBloc(),
  ),
  // Proveedor del MachineryBloc
  BlocProvider<MachineryBloc>(
    create: (context) => MachineryBloc(locator<MaquinariaUseCases>()),
  ),
  // Proveedor del RucBloc
  BlocProvider<RucBloc>(
    create: (context) => RucBloc(locator<FetchRucUseCase>()),
  ),
  // Proveedor del DisponibilidadBloc
  BlocProvider<DisponibilidadBloc>(
    create: (context) =>
        DisponibilidadBloc(locator<GuardarDisponibilidadUseCase>()),
  ),

  // Proveedor del AuthBloc
  BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(locator<AuthUseCases>()),
  ),
];
