// domain/useCases/payment/CreatePaymentUseCase.dart
import '../../models/PaymentModel.dart';
import '../../repository/PaymentRepository.dart';

class CreatePaymentUseCase {
  final PaymentRepository paymentRepository;

  CreatePaymentUseCase(this.paymentRepository);

  Future<PaymentModel> call(Map<String, dynamic> data) {
    return paymentRepository.createPayment(data);
  }
}