import 'package:corvi_app/src/domain/models/Repuestos.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corvi_app/src/domain/useCases/repuestos/RepuestosUseCases.dart'; // Usando AuthUseCases como en LoginBloc
import 'RepuestosEvent.dart';
import 'RepuestosState.dart';

class RepuestosBloc extends Bloc<RepuestosEvent, RepuestosState> {
  final RepuestosUseCases authUseCases; // Casos de uso

  RepuestosBloc(this.authUseCases) : super(RepuestosInitial()) {
    on<FetchRepuestos>(_onFetchRepuestos);
  }

  // Manejar el evento FetchRepuestos
  Future<void> _onFetchRepuestos(
      FetchRepuestos event, Emitter<RepuestosState> emit) async {
    emit(RepuestosLoading());

    // Llamar a AuthUseCases para obtener los repuestos
    final response = await authUseCases.repuestos.getRepuestos();

    // Registrar el contenido de la respuesta para depuración
    print(
        'Respuesta del backend: $response'); // Esto imprimirá la respuesta completa

    // Verificar si la respuesta es un éxito
    if (response is Success<List<Repuesto>>) {
      // Registrar los repuestos recibidos
      print(
          'Repuestos recibidos: ${response.data}'); // Esto imprimirá los datos específicos de los repuestos

      emit(RepuestosLoaded(response.data)); // Accedemos a 'data' si es Success
    } else if (response is Error) {
      // Registrar el error
      print(
          'Error al obtener repuestos: ${(response as Error).message}'); // Esto imprimirá el mensaje de error

      emit(RepuestosError((response as Error).message)); // Manejar el error
    }
  }

  // Filtrar repuestos por categorías
  List<Repuesto> filtrarRepuestosPorCategoria(
      List<Repuesto> repuestos, String categoria) {
    switch (categoria) {
      case 'Electrobombas':
        return repuestos
            .where((r) => r.nombre.contains('Electrobomba'))
            .toList();
      case 'Compresores y Filtros':
        return repuestos
            .where((r) =>
                r.nombre.contains('Compresor') || r.nombre.contains('Filtro'))
            .toList();
      case 'Contactores de Alta Capacidad':
        return repuestos
            .where((r) =>
                r.nombre.contains('Chint') &&
                (r.nombre.contains('115 A') ||
                    r.nombre.contains('80 A') ||
                    r.nombre.contains('65 A')))
            .toList();
      case 'Contactores de Baja Capacidad':
        return repuestos
            .where((r) =>
                r.nombre.contains('Chint') &&
                (r.nombre.contains('50 A') ||
                    r.nombre.contains('40 A') ||
                    r.nombre.contains('32 A') ||
                    r.nombre.contains('25 A') ||
                    r.nombre.contains('18 A') ||
                    r.nombre.contains('12 A')))
            .toList();
      case 'Capacitores de Trabajo (Alta Capacidad)':
        return repuestos
            .where((r) =>
                r.nombre.contains('Capacitor Trabajo') &&
                (r.nombre.contains('25') ||
                    r.nombre.contains('30') ||
                    r.nombre.contains('35') ||
                    r.nombre.contains('40') ||
                    r.nombre.contains('45') ||
                    r.nombre.contains('50')))
            .toList();
      case 'Capacitores de Trabajo (Baja Capacidad)':
        return repuestos
            .where((r) =>
                r.nombre.contains('Capacitor Trabajo') &&
                (r.nombre.contains('5') ||
                    r.nombre.contains('8') ||
                    r.nombre.contains('10') ||
                    r.nombre.contains('12') ||
                    r.nombre.contains('15') ||
                    r.nombre.contains('16') ||
                    r.nombre.contains('17') ||
                    r.nombre.contains('20')))
            .toList();
      case 'Capacitores de Arranque (Alta Capacidad)':
        return repuestos
            .where((r) =>
                r.nombre.contains('Capacitor Arranque') &&
                (r.nombre.contains('124-149') ||
                    r.nombre.contains('189-227') ||
                    r.nombre.contains('200-240') ||
                    r.nombre.contains('250')))
            .toList();
      case 'Capacitores de Arranque (Baja Capacidad)':
        return repuestos
            .where((r) =>
                r.nombre.contains('Capacitor Arranque') &&
                (r.nombre.contains('72-86') || r.nombre.contains('108-130')))
            .toList();
      default:
        return repuestos;
    }
  }
}
