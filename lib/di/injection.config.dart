// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:login_test_task/data/providers/auth_api_provider.dart' as _i597;
import 'package:login_test_task/data/repositories/auth_repository.dart'
    as _i981;
import 'package:login_test_task/di/injection.dart' as _i852;
import 'package:login_test_task/domain/use_cases/check_auth_case.dart' as _i82;
import 'package:login_test_task/domain/use_cases/login_use_case.dart' as _i604;
import 'package:login_test_task/domain/use_cases/logout_use_case.dart' as _i275;
import 'package:login_test_task/presentation/cubit/auth/auth_cubit.dart'
    as _i527;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i597.AuthApiProvider>(() => _i597.AuthApiProvider());
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => registerModule.storage);
    gh.lazySingleton<_i981.AuthRepository>(() => _i981.AuthRepository(
          gh<_i597.AuthApiProvider>(),
          gh<_i558.FlutterSecureStorage>(),
        ));
    gh.factory<_i275.LogoutUseCase>(
        () => _i275.LogoutUseCase(gh<_i981.AuthRepository>()));
    gh.factory<_i604.LoginUseCase>(
        () => _i604.LoginUseCase(gh<_i981.AuthRepository>()));
    gh.factory<_i82.CheckAuthCase>(
        () => _i82.CheckAuthCase(gh<_i981.AuthRepository>()));
    gh.factory<_i527.AuthCubit>(() => _i527.AuthCubit(
          checkAuthCase: gh<_i82.CheckAuthCase>(),
          loginUseCase: gh<_i604.LoginUseCase>(),
          logoutUseCase: gh<_i275.LogoutUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i852.RegisterModule {}
