import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_self_service/src/modules/auth/login/login_route.dart';
import 'package:lab_clinica_self_service/src/repositories/users/user_repository.dart';
import 'package:lab_clinica_self_service/src/repositories/users/user_repository_impl.dart';

class AuthModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<UserRepository>(
          (i) => UserRepositoryImpl(restClient: i()),
        ),
      ];

  @override
  String get moduleRouteName => '/auth';

  @override
  Map<String, WidgetBuilder> get pages => {
    '/login':(context) => const LoginRoute()
  };
}
