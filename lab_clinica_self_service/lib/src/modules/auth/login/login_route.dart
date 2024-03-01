import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_self_service/src/modules/auth/login/login_controller.dart';
import 'package:lab_clinica_self_service/src/modules/auth/login/login_page.dart';
import 'package:lab_clinica_self_service/src/services/user_login_service.dart';
import 'package:lab_clinica_self_service/src/services/user_login_service_impl.dart';

class LoginRoute extends FlutterGetItModulePageRouter {
  const LoginRoute({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<UserLoginService>(
            (i) => UserLoginServiceImpl(userRepository: i())),
        Bind.lazySingleton((i) => LoginController(loginService: i())),
      ];

  @override
  WidgetBuilder get view => (context) => const LoginPage();
}
