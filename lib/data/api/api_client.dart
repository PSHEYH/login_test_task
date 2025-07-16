import 'package:dio/dio.dart';
import 'package:login_test_task/domain/entities/user_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST('/login')
  Future<UserEntity> login(String email, String password);
}
