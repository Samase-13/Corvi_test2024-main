import 'package:corvi_app/src/domain/useCases/disponibilidad/GuardarDisponibilidadUseCase.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';
import 'package:corvi_app/src/presentation/pages/calendar/bloc/DisponibilidadEvent.dart';
import 'package:corvi_app/src/presentation/pages/calendar/bloc/DisponibilidadState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisponibilidadBloc extends Bloc<DisponibilidadEvent, DisponibilidadState> {
  final GuardarDisponibilidadUseCase guardarDisponibilidadUseCase;

  DisponibilidadBloc(this.guardarDisponibilidadUseCase) : super(DisponibilidadInitial()) {
    on<GuardarDisponibilidadEvent>((event, emit) async {
      emit(DisponibilidadLoading());
      try {
        final disponibilidad = event.disponibilidad;
        final result = await guardarDisponibilidadUseCase(disponibilidad);
        
        // Verifica si el resultado es de tipo Success o Error
        if (result is Success<void>) {
          emit(DisponibilidadSuccess());
        } else if (result is Error<void>) {
          emit(DisponibilidadError(result.message));
        } else {
          emit(DisponibilidadError('Error desconocido'));
        }
      } catch (e) {
        emit(DisponibilidadError('Error al guardar la disponibilidad: $e'));
      }
    });
  }
}
