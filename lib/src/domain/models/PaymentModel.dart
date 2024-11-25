// domain/models/PaymentModel.dart
class PaymentModel {
  final String id;
  final String initPoint;
  final double total;

  PaymentModel({
    required this.id,
    required this.initPoint,
    required this.total,
  });

  // Factory method para crear una instancia de PaymentModel a partir de un JSON
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as String,
      initPoint: json['init_point'] as String,
      total: (json['total'] as num).toDouble(),
    );
  }

  // Método para convertir PaymentModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'init_point': initPoint,
      'total': total,
    };
  }
}