import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/model/patient_model.dart';
import 'package:lab_clinica_self_service/src/model/self_service_model.dart';
import 'package:lab_clinica_self_service/src/repositories/information_form/information_form_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

enum FormSteps {
  none,
  whoIAm,
  findPatient,
  patient,
  documents,
  done,
  restart,
}

class SelfServiceController with MessageStateMixin {
  SelfServiceController({
    required this.informationFormRepository,
  });

  final _step = ValueSignal(FormSteps.none);
  var _model = const SelfServiceModel();
  var password = '';
  final InformationFormRepository informationFormRepository;

  SelfServiceModel get model => _model;
  FormSteps get step => _step();

  void startProcess() {
    _step.forceUpdate(FormSteps.whoIAm);
  }

  void setWhoIAmDataStepAndNext(String name, String lastName) {
    _model = _model.copyWith(name: () => name, lastName: () => lastName);
    _step.forceUpdate(FormSteps.findPatient);
  }

  void clearForm() {
    _model = _model.clear();
  }

  void goToFormPatient(PatientModel? patient) {
    _model = _model.copyWith(patient: () => patient);
    _step.forceUpdate(FormSteps.patient);
  }

  void restartProcess() {
    _step.forceUpdate(FormSteps.restart);
    clearForm();
  }

  void updatePatientandGoDocument(PatientModel? patient) {
    _model = _model.copyWith(patient: () => patient);
    _step.forceUpdate(FormSteps.documents);
  }

  void registerDocument(DocumentsType type, String filePath) {
    final documents = _model.documents ?? {};
    if (type == DocumentsType.healthInsuranceCard) {
      documents[type]?.clear();
    }
    final value = documents[type] ?? [];
    value.add(filePath);
    documents[type] = value;
    _model = _model.copyWith(
      documents: () => documents,
    );
  }

  void clearDocuments() {
    _model = _model.copyWith(
      documents: () => {},
    );
  }

  Future<void> finalize() async {
    final result =
        await informationFormRepository.register(model).asyncLoader();
    switch (result) {
      case Left():
        showError('Erro ao registrar atendimento');
      case Right():
        password = "${_model.name} ${model.lastName}";
        _step.forceUpdate(FormSteps.done);
    }
  }
}
