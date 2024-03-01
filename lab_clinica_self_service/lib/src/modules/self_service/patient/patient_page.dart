import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/core/un_focus_extension.dart';
import 'package:lab_clinica_self_service/src/model/self_service_model.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/patient/patient_controller.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/patient/patient_form_controller.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/widgets/lab_clinica_self_service_appbar.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage>
    with PatientFormController, MessagesViewMixin {
  final formKey = GlobalKey<FormState>();
  final selfServiceController = Injector.get<SelfServiceController>();
  final PatientController controller = Injector.get<PatientController>();

  late bool patientFound;
  late bool enableForm;

  @override
  void initState() {
    messageListener(controller);
    final SelfServiceModel(:patient) = selfServiceController.model;
    patientFound = patient != null;
    enableForm = !patientFound;
    initializeForm(patient);
    effect(() {

      if (controller.nextStep) {
        selfServiceController.updatePatientandGoDocument(controller.patient);
        controller.goPreviousStep();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    disposeForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: LabClinicaSelfServiceAppbar(),
      body: Align(
        alignment: Alignment.topCenter,
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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Visibility(
                    visible: patientFound,
                    replacement: Image.asset('assets/images/lupa_icon.png'),
                    child: Image.asset('assets/images/check_icon.png'),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Visibility(
                    visible: patientFound,
                    replacement: const Text(
                      'Cadastro nào encontrado',
                      style: LabClinicaTheme.titleSmallStyle,
                    ),
                    child: const Text(
                      'Cadastro encontrado',
                      style: LabClinicaTheme.titleSmallStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Visibility(
                    visible: patientFound,
                    replacement: const Text(
                      'Preencha o formulario abaixo para fazer o seu cadastro',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: LabClinicaTheme.blueColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    child: const Text(
                      'Confirma os dados do seu cadastro',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: LabClinicaTheme.blueColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: nameEC,
                    onTapOutside: (event) => context.unFocus(),
                    decoration:
                        const InputDecoration(label: Text('Nome do paciente')),
                    validator: Validatorless.required('Nome Obrigatorio'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: emailEC,
                    onTapOutside: (event) => context.unFocus(),
                    decoration: const InputDecoration(label: Text('E-mail')),
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail Obrigatorio'),
                      Validatorless.email('Digite um email valido')
                    ]),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: phoneEC,
                    onTapOutside: (event) => context.unFocus(),
                    decoration: const InputDecoration(
                        label: Text('Telefone de contato')),
                    validator: Validatorless.required('Telefone Obrigatório'),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: documentEC,
                    onTapOutside: (event) => context.unFocus(),
                    decoration:
                        const InputDecoration(label: Text('Digite o seu CPF')),
                    validator: Validatorless.multiple([
                      Validatorless.cpf('Digite um CPF valido'),
                      Validatorless.required('CPF obrigatório')
                    ]),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: cepEC,
                    onTapOutside: (event) => context.unFocus(),
                    decoration: const InputDecoration(label: Text('CEP')),
                    validator: Validatorless.required('CEP Obrigatório'),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Flexible(
                          flex: 3,
                          child: TextFormField(
                            readOnly: !enableForm,
                            controller: streetEC,
                            onTapOutside: (event) => context.unFocus(),
                            decoration:
                                const InputDecoration(label: Text('Endereço')),
                            validator:
                                Validatorless.required('Endereço Obrigatório'),
                          )),
                      const SizedBox(
                        width: 16,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: numberEC,
                          onTapOutside: (event) => context.unFocus(),
                          decoration: const InputDecoration(
                            label: Text('Numero'),
                          ),
                          validator:
                              Validatorless.required('Numero Obrigatório'),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        readOnly: !enableForm,
                        controller: complementEC,
                        onTapOutside: (event) => context.unFocus(),
                        decoration:
                            const InputDecoration(label: Text('Complemento')),
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: stateEC,
                          onTapOutside: (event) => context.unFocus(),
                          decoration: const InputDecoration(
                            label: Text('Estado'),
                          ),
                          validator:
                              Validatorless.required('Estado Obrigatório'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        readOnly: !enableForm,
                        controller: cityEC,
                        onTapOutside: (event) => context.unFocus(),
                        decoration: const InputDecoration(
                          label: Text('Cidade'),
                        ),
                        validator:
                            Validatorless.required('Telefone Obrigatória'),
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: districtEC,
                          onTapOutside: (event) => context.unFocus(),
                          decoration: const InputDecoration(
                            label: Text('Bairro'),
                          ),
                          validator:
                              Validatorless.required('Bairro Obrigatório'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: guardianEC,
                    onTapOutside: (event) => context.unFocus(),
                    decoration:
                        const InputDecoration(label: Text('Responsável')),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: guardianIdentificationNumberEC,
                    onTapOutside: (event) => context.unFocus(),
                    decoration: const InputDecoration(
                      label: Text('Responsável de identificação'),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Visibility(
                    visible: !enableForm,
                    replacement: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          final valid =
                              formKey.currentState?.validate() ?? false;
                          if (valid) {

                            if(patientFound){
                              controller.updateAndNext(updatePatient(
                                selfServiceController.model.patient!));
                            }else{
                              controller.saveAndNext(createPatientRegister());
                            }
                            
                          }
                        },
                        child: Visibility(
                            visible: !patientFound,
                            replacement: const Text('SALVAR E CONTINUAR'),
                            child: const Text('CADASTRAR')),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  enableForm = true;
                                });
                              },
                              child: const Text('Editar'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.patient = selfServiceController.model.patient;
                                controller.goNextStep();
                              },
                              child: const Text('CONTINUAR'),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
