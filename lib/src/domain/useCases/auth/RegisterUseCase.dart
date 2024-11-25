import 'package:corvi_app/src/domain/models/User.dart';
import 'package:corvi_app/src/domain/repository/AuthRepository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  run(Usuario usuario) => repository.register(usuario);
}
