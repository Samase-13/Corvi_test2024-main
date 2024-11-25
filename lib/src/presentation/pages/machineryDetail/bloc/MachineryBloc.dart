import 'package:corvi_app/src/domain/models/Maquinarias.dart';
import 'package:corvi_app/src/domain/useCases/maquinaria/MaquinariaUseCases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'MachineryEvent.dart';
import 'MachineryState.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';

class MachineryBloc extends Bloc<MachineryEvent, MachineryState> {
  final MaquinariaUseCases maquinariaUseCases;

  MachineryBloc(this.maquinariaUseCases) : super(MachineryInitial()) {
    on<FetchMachineryDescription>(_onFetchMachineryDescription);
    on<TogglePriceSelection>(_onTogglePriceSelection);
  }

  Future<void> _onFetchMachineryDescription(
    FetchMachineryDescription event, Emitter<MachineryState> emit) async {
  emit(MachineryLoading());

  final response = await maquinariaUseCases.maquinaria
      .getMaquinariaDetail(event.idMachinery);

  if (response is Success<Maquinaria>) {
    emit(MachineryLoaded(response.data, estado: response.data.estado));
  } else if (response is Error) {
    emit(MachineryError((response as Error).message));
  }
}


  void _onTogglePriceSelection(
      TogglePriceSelection event, Emitter<MachineryState> emit) {
    if (state is MachineryLoaded) {
      final currentState = state as MachineryLoaded;
      emit(currentState.copyWith(isHourlySelected: event.isHourlySelected));
    }
  }
}
