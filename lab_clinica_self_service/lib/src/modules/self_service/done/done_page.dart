import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/self_service_controller.dart';

class DonePage extends StatelessWidget {
  final selfServiceController = Injector.get<SelfServiceController>();
  DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final password = ModalRoute.of(context)?.settings.arguments ??
        'Erro ao recuperar senha.';

    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
              width: sizeOf.width * .85,
              margin: const EdgeInsets.only(top: 18),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: LabClinicaTheme.orangeColor),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/stroke_check.png'),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'ADICIONAR DOCUMENTOS',
                    style: LabClinicaTheme.titleSmallStyle,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 48,
                      minWidth: 218,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: LabClinicaTheme.orangeColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      selfServiceController.password,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'AGUARDE!\n'),
                        TextSpan(text: 'Sua senha será chamada no painel'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: LabClinicaTheme.blueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('IMPRIMIR SENHA'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('Enviar SMS'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LabClinicaTheme.orangeColor,
                      ),
                      onPressed: () {
                        selfServiceController.restartProcess();
                      },
                      child: const Text(
                        'FINALIZAR',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
