import 'package:corvi_app/src/domain/models/Repuestos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'DescriptionPartsEvent.dart';
import 'DescriptionPartsState.dart';
import 'package:corvi_app/src/domain/utils/Resource.dart';
import 'package:corvi_app/src/domain/useCases/repuestos/RepuestosUseCases.dart';

class DescriptionPartsBloc
    extends Bloc<DescriptionPartsEvent, DescriptionPartsState> {
  final RepuestosUseCases authUseCases;

  DescriptionPartsBloc(this.authUseCases) : super(DescriptionPartsInitial()) {
    // Registra los eventos que maneja este Bloc
    on<FetchPartDescription>(_onFetchPartDescription);
    on<IncrementQuantity>(_onIncrementQuantity); // Corrección aquí
    on<DecrementQuantity>(_onDecrementQuantity); // Corrección aquí
  }

  Future<void> _onFetchPartDescription(
      FetchPartDescription event, Emitter<DescriptionPartsState> emit) async {
    emit(DescriptionPartsLoading());

    // Llamada al caso de uso para obtener la descripción del repuesto
    final response =
        await authUseCases.repuestos.getRepuestoDetail(event.partId);

    if (response is Success<Repuesto>) {
      emit(DescriptionPartsLoaded(response.data));
    } else if (response is Error) {
      emit(DescriptionPartsError((response as Error).message));
    }
  }

  // Función manejadora para el evento de incremento de cantidad
  void _onIncrementQuantity(
      IncrementQuantity event, Emitter<DescriptionPartsState> emit) {
    if (state is DescriptionPartsLoaded) {
      final currentState = state as DescriptionPartsLoaded;
      emit(currentState.copyWith(quantity: currentState.quantity + 1));
    }
  }

  // Función manejadora para el evento de decremento de cantidad
  void _onDecrementQuantity(
      DecrementQuantity event, Emitter<DescriptionPartsState> emit) {
    if (state is DescriptionPartsLoaded) {
      final currentState = state as DescriptionPartsLoaded;
      if (currentState.quantity > 0) {
        emit(currentState.copyWith(quantity: currentState.quantity - 1));
      }
    }
  }
}
