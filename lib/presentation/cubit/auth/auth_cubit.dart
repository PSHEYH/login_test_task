import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:login_test_task/domain/entities/user_entity.dart';
import 'package:login_test_task/domain/use_cases/check_auth_case.dart';
import 'package:login_test_task/domain/use_cases/login_use_case.dart';
import 'package:login_test_task/domain/use_cases/logout_use_case.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthCase checkAuthCase;

  AuthCubit(
      {required this.checkAuthCase,
      required this.loginUseCase,
      required this.logoutUseCase})
      : super(const AuthState());

  UserEntity? _userEntity;

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool isEmailValidated = false;
  bool isPasswordValidated = false;

  String errorMessage = '';

  String get username {
    return _userEntity != null ? _userEntity!.username : '';
  }

  bool get isValidated {
    return isEmailValidated && isPasswordValidated;
  }

  Future<bool> checkAuth() async {
    _userEntity = await checkAuthCase();
    return _userEntity != null;
  }

  Future<void> login() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      _userEntity = await loginUseCase(
          emailTextEditingController.text, passwordTextEditingController.text);
      emit(state.copyWith(status: AuthStatus.authenticated));
    } catch (e) {
      errorMessage = e.toString();
      emit(state.copyWith(status: AuthStatus.error));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      bool isLogOuted = await logoutUseCase.call();
      if (isLogOuted) {
        emailTextEditingController.clear();
        passwordTextEditingController.clear();
        emit(state.copyWith(status: AuthStatus.initial));
      } else {
        errorMessage = 'Something goes wrong';
        emit(state.copyWith(status: AuthStatus.error));
      }
    } catch (e) {
      errorMessage = e.toString();
      emit(state.copyWith(status: AuthStatus.error));
    }
  }

  clearTextFields() {
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
  }

  String? onValidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      isEmailValidated = false;
      return 'Please enter email';
    }
    final regex = RegExp(r'^\S+@\S+\.\S+$');
    if (!regex.hasMatch(value)) {
      isEmailValidated = false;
      return "Invalid email";
    }
    isEmailValidated = true;
    return null;
  }

  String? onValidatePassword(String? value) {
    if (value == null || value.isEmpty) {
      isPasswordValidated = false;
      return 'Please enter password';
    } else if (value.length < 6) {
      isPasswordValidated = false;
      return 'password too short';
    }
    isPasswordValidated = true;
    return null;
  }
}
