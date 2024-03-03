import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/bindings/lab_clinicas_application_bindings.dart';
import 'package:lab_clinica_self_service/src/modules/auth/auth_module.dart';
import 'package:lab_clinica_self_service/src/modules/home/home_module.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/self_service_module.dart';
import 'package:lab_clinica_self_service/src/pages/splash_page/splash_page.dart';

late List<CameraDescription> _camera;
void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      _camera = await availableCameras();
      runApp(
        const LabClinicaSelfServiceApp(),
      );
    },
    (error, stack) {
      log('Erro nao tratado', error: error, stackTrace: stack);
      throw error;
    },
  );
}

class LabClinicaSelfServiceApp extends StatelessWidget {
  const LabClinicaSelfServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      
      title: "Lab Clinicas Auto-Atendimento",
      bindings: LabClinicasApplicationBindings(),
      pagesBuilders: [
        FlutterGetItPageBuilder(
            page: (context) => const SplashPage(), path: '/')
      ],
      modules: [
        AuthModule(),
        HomeModule(),
        SelfServiceModule(),
      ],
      didStart: () {
        FlutterGetItBindingRegister.registerPermanentBinding(
          'CAMERAS',
          [
            Bind.lazySingleton((i) => _camera),
          ],
        );
      },
    );
  }
}
