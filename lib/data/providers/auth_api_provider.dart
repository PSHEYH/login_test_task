import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:login_test_task/data/api/api_client.dart';
import 'package:login_test_task/domain/entities/user_entity.dart';

@injectable
class AuthApiProvider {
  AuthApiProvider() {
    dio.options.baseUrl = dotenv.env['API_URL']!;
  }

  final dio = Dio();
  Future<UserEntity> login(
      {required String email, required String password}) async {
    final client = RestClient(dio);
    return await client.login(email, password);
  }

  Future<bool> logout() async {
    return true;
  }
}
