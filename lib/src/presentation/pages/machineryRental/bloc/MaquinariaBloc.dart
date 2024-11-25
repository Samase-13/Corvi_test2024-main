import 'package:corvi_app/src/domain/models/Maquinarias.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corvi_app/src/domain/useCases/maquinaria/MaquinariaUseCases.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';
import 'MaquinariaEvent.dart';
import 'MaquinariaState.dart';

class MaquinariaBloc extends Bloc<MaquinariaEvent, MaquinariaState> {
  final MaquinariaUseCases maquinariaUseCases;

  MaquinariaBloc(this.maquinariaUseCases) : super(MaquinariaInitial()) {
    on<FetchMaquinaria>(_onFetchMaquinaria);
    on<FetchFilteredMaquinaria>(_onFetchFilteredMaquinaria);
  }

  // Manejar el evento FetchMaquinaria
  Future<void> _onFetchMaquinaria(
      FetchMaquinaria event, Emitter<MaquinariaState> emit) async {
    emit(MaquinariaLoading());

    final response = await maquinariaUseCases.maquinaria.getMaquinaria();

    // Verificar si la respuesta es un éxito
    if (response is Success<List<Maquinaria>>) {
      emit(MaquinariaLoaded(response.data));
    } else if (response is Error) {
      emit(MaquinariaError((response as Error).message));
    }
  }

  Future<void> _onFetchFilteredMaquinaria(
    FetchFilteredMaquinaria event, Emitter<MaquinariaState> emit) async {
  emit(MaquinariaLoading());

  final response = await maquinariaUseCases.maquinaria.getMaquinaria();

  if (response is Success<List<Maquinaria>>) {
    // Filtrar maquinaria por el tipo especificado
    final filtrada = filtrarMaquinariaPorTipo(response.data, event.tipo);
    emit(MaquinariaLoaded(filtrada));
  } else if (response is Error) {
    emit(MaquinariaError((response as Error).message));
  }
}

  // Filtrar maquinaria por categorías
  List<Maquinaria> filtrarMaquinariaPorTipo(
      List<Maquinaria> maquinaria, String tipo) {
    switch (tipo) {
      case 'Excavadoras':
        return maquinaria.where((m) => m.tipo == 'Excavadoras').toList();
      case 'Cargadores':
        return maquinaria.where((m) => m.tipo == 'Cargadores').toList();
      case 'Bulldozers':
        return maquinaria.where((m) => m.tipo == 'Bulldozers').toList();
      case 'Retroexcavadora':
        return maquinaria.where((m) => m.tipo == 'Retroexcavadora').toList();
      case 'Rodillos Compactadores':
        return maquinaria.where((m) => m.tipo == 'Rodillos Compactadores').toList();
      case 'Camiones de Volquete':
        return maquinaria.where((m) => m.tipo == 'Camiones de Volquete').toList();
      case 'Tractores':
        return maquinaria.where((m) => m.tipo == 'Tractores').toList();
      default:
        return maquinaria;
    }
  }
}
