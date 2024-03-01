import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/core/un_focus_extension.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/find_patient/find_patient_controller.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/widgets/lab_clinica_self_service_appbar.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:validatorless/validatorless.dart';

class FindPatientPage extends StatefulWidget {
  const FindPatientPage({super.key});

  @override
  State<FindPatientPage> createState() => _FindPatientPageState();
}

class _FindPatientPageState extends State<FindPatientPage>
    with MessagesViewMixin {
  final formKey = GlobalKey<FormState>();
  final documentEC = TextEditingController();
  final controller = Injector.get<FindPatientController>();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      final FindPatientController(:patient, :patientNotFound) = controller;

      if (patient != null || patientNotFound != null) {
        Injector.get<SelfServiceController>().goToFormPatient(patient);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    documentEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: LabClinicaSelfServiceAppbar(),
      body: LayoutBuilder(builder: (_, constraints) {
        return SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_login.png'),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                width: sizeOf.width * .8,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Image.asset('assets/images/logo_vertical.png'),
                      const SizedBox(
                        height: 48,
                      ),
                      const Text(
                        'Bem vindo!',
                        style: LabClinicaTheme.titleStyle,
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter()
                        ],
                        decoration: const InputDecoration(
                          label: Text('Digite o CPF do paciente.'),
                        ),
                        controller: documentEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Digite o CPF'),
                          Validatorless.cpf('Digite um CPF valido')
                        ]),
                        // validator: Validatorless.multiple([
                        //   Validatorless.required('CPF obrigatório'),
                        //   Validatorless.cpf('Digite um CPF válido'),
                        // ]),
                        onTapOutside: (event) => context.unFocus(),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Nào sabe o CPF do paciente",
                            style: TextStyle(
                              fontSize: 14,
                              color: LabClinicaTheme.blueColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextButton(
                            child: const Text(
                              "Clique aqui",
                              style: TextStyle(
                                fontSize: 14,
                                color: LabClinicaTheme.orangeColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              controller.continueWithoutDocument();
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: sizeOf.width * .8,
                        height: 48,
                        child: ElevatedButton(
                          child: const Text(
                            'CONTINUAR',
                          ),
                          onPressed: () {
                            final valid =
                                formKey.currentState?.validate() ?? false;
                            if (valid) {
                              controller.findPatientByDocument(documentEC.text);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
