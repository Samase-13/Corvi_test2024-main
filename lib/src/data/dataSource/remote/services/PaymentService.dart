// data/dataSource/remote/services/PaymentService.dart
import 'package:corvi_app/src/data/api/ApiConfig.dart';
import 'package:corvi_app/src/domain/models/PaymentModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PaymentService {
  final String _baseUrl = ApiConfig.API;

  Future<PaymentModel> createPayment(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/api/pago/create_preference"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return PaymentModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create payment preference');
    }
  }
}