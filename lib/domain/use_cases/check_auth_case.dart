import 'package:injectable/injectable.dart';
import 'package:login_test_task/data/repositories/auth_repository.dart';
import 'package:login_test_task/domain/entities/user_entity.dart';

@injectable
class CheckAuthCase {
  final AuthRepository authRepository;
  CheckAuthCase(this.authRepository);

  Future<UserEntity?> call() async {
    return await authRepository.checkAuth();
  }
}
