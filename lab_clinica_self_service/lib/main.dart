import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/bindings/lab_clinicas_application_bindings.dart';
import 'package:lab_clinica_self_service/src/pages/splash_page/splash_page.dart';

void main() {
  runApp(const LabClinicaSelfServiceApp());
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
            page: (context) => const SplashPage(),
            path: '/')
      ],
    );
  }
}
