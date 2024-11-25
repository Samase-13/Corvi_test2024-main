import 'package:corvi_app/src/domain/repository/AuthRepository.dart';

class GetUserSessionUseCase {
  final AuthRepository authRepository;

  GetUserSessionUseCase(this.authRepository);

  run() => authRepository.getUserSession();
}
