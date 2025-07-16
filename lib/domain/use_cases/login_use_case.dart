import 'package:injectable/injectable.dart';
import 'package:login_test_task/data/repositories/auth_repository.dart';
import 'package:login_test_task/domain/entities/user_entity.dart';

@injectable
class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);

  Future<UserEntity> call(String email, String password) async {
    return await authRepository.login(email, password);
  }
}
