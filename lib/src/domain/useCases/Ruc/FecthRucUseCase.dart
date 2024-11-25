import 'package:corvi_app/src/domain/models/RucData.dart';
import 'package:corvi_app/src/domain/repository/RucRepository.dart';

class FetchRucUseCase {
  final RucRepository rucRepository;

  FetchRucUseCase(this.rucRepository);

  Future<RucData> call(String ruc) async {
    return await rucRepository.fetchRucData(ruc);
  }
}