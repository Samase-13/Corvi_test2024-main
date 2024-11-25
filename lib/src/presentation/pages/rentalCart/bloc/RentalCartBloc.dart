import 'package:corvi_app/src/presentation/pages/rentalCart/bloc/RentalCartState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'RentalCartEvent.dart';

class RentalCartBloc extends Bloc<RentalCartEvent, RentalCartState> {
  RentalCartBloc() : super(RentalCartInitial()) {
    on<SetRentalDetails>((event, emit) {
      emit(RentalCartLoaded(
        event.img,
        event.nombre,
        event.tipo,
        event.precio,
        event.precioTipo,
      ));
    });

    on<CalculateTotal>((event, emit) {
      final total = event.quantity * event.pricePerUnit;
      emit(RentalCartTotalCalculated(total));
    });
  }
}
