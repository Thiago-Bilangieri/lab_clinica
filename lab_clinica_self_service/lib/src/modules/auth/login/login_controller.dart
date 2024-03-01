// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'package:lab_clinica_self_service/src/services/user_login_service.dart';

class LoginController with MessageStateMixin {
  final UserLoginService _userLoginService;

  LoginController({
    required UserLoginService loginService,
  }) : _userLoginService = loginService;

  final _obscurePassword = signal(true);
  final _logged = signal(false);
  bool get logged => _logged();

  bool get obscurePassword => _obscurePassword();

  get pa => null;

  void passwordToggle() {
    _obscurePassword.value = !_obscurePassword();
  }

  Future<void> login(String email, String password) async {
    final loginResult =
        await _userLoginService.execute(email, password).asyncLoader();
    switch (loginResult) {
      case Left(value: ServiceException(:final message)):
        showError(message);
      case Right(value: _):
        _logged.value = true;
    }
  }
}
