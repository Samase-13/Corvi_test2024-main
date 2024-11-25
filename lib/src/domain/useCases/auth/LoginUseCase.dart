import 'package:corvi_app/src/domain/repository/AuthRepository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  run(String correo, String password) => repository.login(correo, password);
}
