import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/model/patient_model.dart';
import 'package:lab_clinica_self_service/src/repositories/patient/patients_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class FindPatientController with MessageStateMixin {
  FindPatientController({
    required PatientsRepository patientRepository,
  }) : _patientRepository = patientRepository;

  final PatientsRepository _patientRepository;
  final _patientNotFound = ValueSignal<bool?>(null);
  final _patient = ValueSignal<PatientModel?>(null);

  bool? get patientNotFound => _patientNotFound();
  PatientModel? get patient => _patient();

  Future<void> findPatientByDocument(String document) async {
    final patientResult =
        await _patientRepository.findPatientByDocument(document);

    bool? patientNotFound;
    PatientModel? patient;

    switch (patientResult) {
      case Right(value: PatientModel model?):
        patientNotFound = false;
        patient = model;
      case Right(value: _):
        patientNotFound = true;
        patient = null;
      case Left():
        showError('Erro ao buscar paciente');
        return;
    }
    batch(() {
      _patient.value = patient;
      _patientNotFound.forceUpdate(patientNotFound);
    });
  }

  void continueWithoutDocument() {
    batch(() {
      _patient.value = null;
      _patientNotFound.forceUpdate(true);
    });
  }
}
