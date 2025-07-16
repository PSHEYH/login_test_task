import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:login_test_task/data/providers/auth_api_provider.dart';
import 'package:login_test_task/domain/entities/user_entity.dart';

@LazySingleton()
class AuthRepository {
  final AuthApiProvider api;
  final FlutterSecureStorage storage;

  AuthRepository(this.api, this.storage);

  Future<UserEntity?> checkAuth() async {
    String? userData = await storage.read(key: 'user_data');
    if (userData != null) {
      try {
        return UserEntity.fromJson(jsonDecode(userData));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<UserEntity> login(String email, String password) async {
    UserEntity result = await api.login(email: email, password: password);
    await storage.write(key: 'user_data', value: jsonEncode(result.toJson()));
    return result;
  }

  Future<bool> logout() async {
    try {
      bool isLogout = await api.logout();
      await storage.delete(key: 'user_data');
      return isLogout;
    } catch (e) {
      return false;
    }
  }
}
