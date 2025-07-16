import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  FlutterSecureStorage get storage => const FlutterSecureStorage();
}
