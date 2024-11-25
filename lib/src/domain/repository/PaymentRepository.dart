// domain/repository/PaymentRepository.dart
import '../models/PaymentModel.dart';

abstract class PaymentRepository {
  Future<PaymentModel> createPayment(Map<String, dynamic> data);
}
