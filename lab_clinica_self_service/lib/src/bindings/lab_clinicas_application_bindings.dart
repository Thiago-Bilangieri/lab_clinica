import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/core/env.dart';

class LabClinicasApplicationBindings extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() =>
      [Bind.lazySingleton<RestClient>((i) => RestClient(Env.backendBaseUrl))];
}
