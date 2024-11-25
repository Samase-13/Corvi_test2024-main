import 'package:corvi_app/src/domain/models/RucData.dart';

abstract class RucRepository {
  Future<RucData> fetchRucData(String ruc);
}