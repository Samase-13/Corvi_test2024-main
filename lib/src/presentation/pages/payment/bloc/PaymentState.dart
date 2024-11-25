// presentation/payment/bloc/PaymentState.dart

import 'package:corvi_app/src/domain/models/PaymentModel.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final PaymentModel payment;

  PaymentSuccess(this.payment);
}

class PaymentError extends PaymentState {
  final String message;

  PaymentError(this.message);
}