// data/repository/PaymentRepositoryImpl.dart
import 'package:corvi_app/src/domain/models/PaymentModel.dart';
import 'package:corvi_app/src/domain/repository/PaymentRepository.dart';
import '../dataSource/remote/services/PaymentService.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentService paymentService;

  PaymentRepositoryImpl(this.paymentService);

  @override
  Future<PaymentModel> createPayment(Map<String, dynamic> data) {
    return paymentService.createPayment(data);
  }
}