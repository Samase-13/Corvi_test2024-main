// presentation/payment/bloc/PaymentEvent.dart
abstract class PaymentEvent {}

class CreatePayment extends PaymentEvent {
  final Map<String, dynamic> data;

  CreatePayment(this.data);
}