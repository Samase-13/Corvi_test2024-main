import 'package:corvi_app/src/domain/models/User.dart';
import 'package:corvi_app/src/domain/repository/AuthRepository.dart';

class SaveUserSessionUseCase {
  final AuthRepository authRepository;

  SaveUserSessionUseCase(this.authRepository);

  run(Usuario usuario) => authRepository.saveUserSession(usuario);
}
