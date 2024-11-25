// presentation/payment/bloc/PaymentBloc.dart
import 'package:corvi_app/src/domain/useCases/Payment/PaymentUseCase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'PaymentEvent.dart';
import 'PaymentState.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CreatePaymentUseCase createPaymentUseCase;

  PaymentBloc({required this.createPaymentUseCase}) : super(PaymentInitial()) {
    on<CreatePayment>((event, emit) async {
      emit(PaymentLoading());
      try {
        final payment = await createPaymentUseCase.call(event.data);
        emit(PaymentSuccess(payment));
      } catch (e) {
        emit(PaymentError(e.toString()));
      }
    });
  }
}