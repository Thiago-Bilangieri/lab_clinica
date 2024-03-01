import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/core/un_focus_extension.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class WhoIAmPage extends StatefulWidget {
  const WhoIAmPage({super.key});

  @override
  State<WhoIAmPage> createState() => _WhoIAmPageState();
}

class _WhoIAmPageState extends State<WhoIAmPage> {
  final selfServiceController = Injector.get<SelfServiceController>();
  final formKey = GlobalKey<FormState>();
  final firstNameEC = TextEditingController();
  final lastNameEC = TextEditingController();

  @override
  void dispose() {
    firstNameEC.dispose();
    lastNameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        firstNameEC.text ='';
        lastNameEC.text = '';
        selfServiceController.clearForm();
      },
      child: Scaffold(
        appBar: LabClinicasAppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Finalizar terminal'),
                    
                  )
                ];
              },
              onSelected: (value) async {
                if(value==1){
                  final nav = Navigator.of(context);
                  await SharedPreferences.getInstance().then((sp) => sp.clear());
                  nav.pushNamedAndRemoveUntil('/', (route) => false);
                }
              },
              child: const IconPopupMenuWidget(),
            )
          ],
        ),
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
                          decoration: const InputDecoration(
                            label: Text('Digite seu nome'),
                          ),
                          controller: firstNameEC,
                          validator: Validatorless.required('Nome obrigatório'),
                          onTapOutside: (event) => context.unFocus(),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Digite seu sobrenome"),
                          ),
                          controller: lastNameEC,
                          validator:
                              Validatorless.required('Sobrenome obrigatório'),
                              onTapOutside: (event) => context.unFocus(),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          width: sizeOf.width * .8,
                          height: 48,
                          child: ElevatedButton(
                            child: const Text(
                              'Continuar',
                            ),
                            onPressed: () {
                              final valid =
                                  formKey.currentState?.validate() ?? false;
                              if (valid) {
                                selfServiceController.setWhoIAmDataStepAndNext(
                                    firstNameEC.text, lastNameEC.text);
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
      ),
    );
  }
}
