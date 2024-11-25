import 'package:injectable/injectable.dart';

import 'package:corvi_app/src/data/dataSource/remote/services/AuthService.dart';
import 'package:corvi_app/src/data/repository/AuthRepositoryImpl.dart';
import 'package:corvi_app/src/domain/repository/AuthRepository.dart';
import 'package:corvi_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:corvi_app/src/domain/useCases/auth/GetUserSessionUseCase.dart';
import 'package:corvi_app/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:corvi_app/src/domain/useCases/auth/LogoutUseCase.dart';
import 'package:corvi_app/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:corvi_app/src/domain/useCases/auth/SaveUserSessionUseCase.dart';

// Otros servicios y repositorios importados en tu proyecto actual
import 'package:corvi_app/src/data/dataSource/remote/services/MaquinariaService.dart';
import 'package:corvi_app/src/data/dataSource/remote/services/RepuestosService.dart';
import 'package:corvi_app/src/data/dataSource/remote/services/RucServiced.dart';
import 'package:corvi_app/src/data/dataSource/remote/services/DisponibilidadService.dart';
import 'package:corvi_app/src/data/repository/DisponiblidadRepositoryImpl.dart';
import 'package:corvi_app/src/data/repository/MaquinariaRepositoryImpl.dart';
import 'package:corvi_app/src/data/repository/RepuestosRepositoryImpl.dart';
import 'package:corvi_app/src/data/repository/RucRepositoryImpl.dart';
import 'package:corvi_app/src/domain/repository/MaquinariaRepository.dart';
import 'package:corvi_app/src/domain/repository/RepuestosRepository.dart';
import 'package:corvi_app/src/domain/repository/RucRepository.dart';
import 'package:corvi_app/src/domain/repository/DisponibilidadRepository.dart';
import 'package:corvi_app/src/domain/useCases/disponibilidad/GuardarDisponibilidadUseCase.dart';
import 'package:corvi_app/src/domain/useCases/maquinaria/MaquinariaUseCase.dart';
import 'package:corvi_app/src/domain/useCases/maquinaria/MaquinariaUseCases.dart';
import 'package:corvi_app/src/domain/useCases/repuestos/RepuestosUseCase.dart';
import 'package:corvi_app/src/domain/useCases/repuestos/RepuestosUseCases.dart';
import 'package:corvi_app/src/domain/useCases/Ruc/FecthRucUseCase.dart';

@module
abstract class AppModule {
  // Inyección para el servicio de autenticación
  @injectable
  AuthService get authService => AuthService();

  @injectable
  AuthRepository get authRepository => AuthRepositoryImpl(authService);

  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository),
    getUserSession: GetUserSessionUseCase(authRepository),
    saveUserSession: SaveUserSessionUseCase(authRepository),
    logout: LogoutUseCase(authRepository),
  );

  // Inyección para Repuestos
  @injectable
  RepuestosService get repuestosService => RepuestosService();

  @injectable
  RepuestosRepository get repuestosRepository => RepuestosRepositoryImpl(repuestosService);

  @injectable
  RepuestosUseCases get repuestosUseCases => RepuestosUseCases(
    repuestos: RepuestosUseCase(repuestosRepository),
  );

  // Inyección para Maquinaria
  @injectable
  MaquinariaService get maquinariaService => MaquinariaService();

  @injectable
  MaquinariaRepository get maquinariaRepository => MaquinariaRepositoryImpl(maquinariaService);

  @injectable
  MaquinariaUseCases get maquinariaUseCases => MaquinariaUseCases(
    maquinaria: MaquinariaUseCase(maquinariaRepository),
  );

  // Inyección para RUC
  @injectable
  RucService get rucService => RucService();

  @injectable
  RucRepository get rucRepository => RucRepositoryImpl(rucService);

  @injectable
  FetchRucUseCase get fetchRucUseCase => FetchRucUseCase(rucRepository);

  // Inyección para Disponibilidad
  @injectable
  DisponibilidadService get disponibilidadService => DisponibilidadService();

  @injectable
  DisponibilidadRepository get disponibilidadRepository => DisponibilidadRepositoryImpl(disponibilidadService);

  @injectable
  GuardarDisponibilidadUseCase get guardarDisponibilidadUseCase => GuardarDisponibilidadUseCase(disponibilidadRepository);
}
