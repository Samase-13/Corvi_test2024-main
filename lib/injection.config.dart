// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:corvi_app/src/data/dataSource/remote/services/AuthService.dart'
    as _i413;
import 'package:corvi_app/src/data/dataSource/remote/services/DisponibilidadService.dart'
    as _i375;
import 'package:corvi_app/src/data/dataSource/remote/services/MaquinariaService.dart'
    as _i527;
import 'package:corvi_app/src/data/dataSource/remote/services/RepuestosService.dart'
    as _i9;
import 'package:corvi_app/src/data/dataSource/remote/services/RucServiced.dart'
    as _i101;
import 'package:corvi_app/src/di/AppModule.dart' as _i532;
import 'package:corvi_app/src/domain/repository/AuthRepository.dart' as _i252;
import 'package:corvi_app/src/domain/repository/DisponibilidadRepository.dart'
    as _i935;
import 'package:corvi_app/src/domain/repository/MaquinariaRepository.dart'
    as _i983;
import 'package:corvi_app/src/domain/repository/RepuestosRepository.dart'
    as _i816;
import 'package:corvi_app/src/domain/repository/RucRepository.dart' as _i40;
import 'package:corvi_app/src/domain/useCases/auth/AuthUseCases.dart' as _i248;
import 'package:corvi_app/src/domain/useCases/disponibilidad/GuardarDisponibilidadUseCase.dart'
    as _i965;
import 'package:corvi_app/src/domain/useCases/maquinaria/MaquinariaUseCases.dart'
    as _i277;
import 'package:corvi_app/src/domain/useCases/repuestos/RepuestosUseCases.dart'
    as _i225;
import 'package:corvi_app/src/domain/useCases/Ruc/FecthRucUseCase.dart'
    as _i1065;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i413.AuthService>(() => appModule.authService);
    gh.factory<_i252.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i248.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i9.RepuestosService>(() => appModule.repuestosService);
    gh.factory<_i816.RepuestosRepository>(() => appModule.repuestosRepository);
    gh.factory<_i225.RepuestosUseCases>(() => appModule.repuestosUseCases);
    gh.factory<_i527.MaquinariaService>(() => appModule.maquinariaService);
    gh.factory<_i983.MaquinariaRepository>(
        () => appModule.maquinariaRepository);
    gh.factory<_i277.MaquinariaUseCases>(() => appModule.maquinariaUseCases);
    gh.factory<_i101.RucService>(() => appModule.rucService);
    gh.factory<_i40.RucRepository>(() => appModule.rucRepository);
    gh.factory<_i1065.FetchRucUseCase>(() => appModule.fetchRucUseCase);
    gh.factory<_i375.DisponibilidadService>(
        () => appModule.disponibilidadService);
    gh.factory<_i935.DisponibilidadRepository>(
        () => appModule.disponibilidadRepository);
    gh.factory<_i965.GuardarDisponibilidadUseCase>(
        () => appModule.guardarDisponibilidadUseCase);
    return this;
  }
}

class _$AppModule extends _i532.AppModule {}
