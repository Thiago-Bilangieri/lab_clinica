// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/model/patient_model.dart';

import 'package:lab_clinica_self_service/src/repositories/patient/patients_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PatientController with MessageStateMixin {
  PatientController({required PatientsRepository repository})
      : _repository = repository;

  final PatientsRepository _repository;
  PatientModel? patient;
  final _nextStep = signal<bool>(false);
  bool get nextStep => _nextStep();

  void goNextStep() {
    _nextStep.value = true;
  }
    void goPreviousStep() {
    _nextStep.value = false;
  }

  Future<void> updateAndNext(PatientModel model) async {
    final updateResult = await _repository.update(model);

    switch (updateResult) {
      case Left():
        showError('Erro ao atualizar dados do paciente, chame o atendente');
      case Right():
        showSuccess('Paciente atualizado com sucesso!!');
        patient = model;
        goNextStep();
    }
  }

  Future<void> saveAndNext(RegisterPatientModel registerPatientModel) async {
    final result = await _repository.register(registerPatientModel);
    switch(result){
      
      case Left():
        showError('Erro ao cadastrar paciente, chame pelo atendente');
      case Right(value: final patient):
        showInfo('Paciente cadastrado com sucesso');
        this.patient = patient;
goNextStep();
    }
  }
}
