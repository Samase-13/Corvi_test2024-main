import 'package:corvi_app/src/domain/useCases/Ruc/FecthRucUseCase.dart';
import 'package:corvi_app/src/presentation/pages/ruc/bloc/RucEvent.dart';
import 'package:corvi_app/src/presentation/pages/ruc/bloc/RucState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RucBloc extends Bloc<RucEvent, RucState> {
  final FetchRucUseCase fetchRucUseCase;

  RucBloc(this.fetchRucUseCase) : super(RucInitial()) {
    on<FetchRucEvent>((event, emit) async {
      emit(RucLoading());
      try {
        final rucData = await fetchRucUseCase.call(event.ruc);
        emit(RucSuccess(rucData));
        print(
            "Ruc data fetched: $rucData"); // Línea de depuración para verificar los datos
      } catch (e) {
        emit(RucError('Error al obtener el RUC: ${e.toString()}'));
        print("Error: ${e.toString()}"); // Línea de depuración para errores
      }
    });
  }
}
