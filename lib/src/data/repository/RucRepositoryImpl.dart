
import 'package:corvi_app/src/data/dataSource/remote/services/RucServiced.dart';
import 'package:corvi_app/src/domain/models/RucData.dart';
import 'package:corvi_app/src/domain/repository/RucRepository.dart';

class RucRepositoryImpl implements RucRepository {
  final RucService rucService;

  RucRepositoryImpl(this.rucService);

  @override
  Future<RucData> fetchRucData(String ruc) async {
    return await rucService.fetchRucData(ruc);
  }
}