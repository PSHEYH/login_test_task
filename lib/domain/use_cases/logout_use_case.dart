import 'package:injectable/injectable.dart';
import 'package:login_test_task/data/repositories/auth_repository.dart';

@injectable
class LogoutUseCase {
  final AuthRepository authRepository;
  LogoutUseCase(this.authRepository);

  Future<bool> call() async {
    return await authRepository.logout();
  }
}
